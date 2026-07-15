import assert from "node:assert/strict";
import { buildApp, ROUTE_AUTHORIZATION_DESCRIPTORS } from "../http/app.js";
import { makeProducerResult } from "./producer.js";
import { captureCase, emitProducer } from "./scenario_result.js";

const results = {
  "valid-current-inventory": await captureCase(validCurrentInventory),
  "late-direct-route-rejected": await captureCase(lateDirectRouteRejected),
  "encapsulated-plugin-route-rejected": await captureCase(
    encapsulatedPluginRouteRejected,
  ),
  "missing-descriptor-rejected": await captureCase(missingDescriptorRejected),
  "duplicate-route-rejected": await captureCase(duplicateRouteRejected),
  "wrong-operation-or-classification-rejected": await captureCase(
    wrongOperationOrClassificationRejected,
  ),
};

const producer = makeProducerResult("route-inventory", results);
emitProducer("route-inventory", producer);
process.stdout.write(
  `ROUTE_INVENTORY_PRODUCER=${producer.passed ? "true" : "false"}\n`,
);
if (!producer.passed) process.exitCode = 1;

async function validCurrentInventory() {
  const app = buildApp({ authorization: { kind: "disabled" } });
  try {
    await app.ready();
  } finally {
    await app.close();
  }
}

async function lateDirectRouteRejected() {
  const app = buildApp({ authorization: { kind: "disabled" } });
  try {
    app.get("/v1/late", async () => ({ ok: true }));
    await assert.rejects(
      Promise.resolve(app.ready()),
      /actual route authorization inventory mismatch/,
    );
  } finally {
    await app.close();
  }
}

async function encapsulatedPluginRouteRejected() {
  const app = buildApp({ authorization: { kind: "disabled" } });
  try {
    app.register(async (plugin) => {
      plugin.get("/v1/plugin-extra", async () => ({ ok: true }));
    });
    await assert.rejects(
      Promise.resolve(app.ready()),
      /actual route authorization inventory mismatch/,
    );
  } finally {
    await app.close();
  }
}

async function missingDescriptorRejected() {
  await withDescriptorMutation(
    () => {
      mutableDescriptors().splice(0, 1);
    },
    async () => {
      assert.throws(
        () => buildApp({ authorization: { kind: "hosted" } as never }),
        /route authorization inventory mismatch/,
      );
    },
  );
}

async function duplicateRouteRejected() {
  await withDescriptorMutation(
    () => {
      mutableDescriptors().push(ROUTE_AUTHORIZATION_DESCRIPTORS[0]);
    },
    async () => {
      assert.throws(
        () => buildApp({ authorization: { kind: "hosted" } as never }),
        /route authorization inventory mismatch|duplicate route authorization descriptor/,
      );
    },
  );
}

async function wrongOperationOrClassificationRejected() {
  await withDescriptorMutation(
    () => {
      const first = mutableDescriptors()[0] as {
        operation: string;
      };
      first.operation = "wrong-operation";
    },
    async () => {
      assert.throws(
        () => buildApp({ authorization: { kind: "hosted" } as never }),
        /route authorization inventory mismatch/,
      );
    },
  );
}

async function withDescriptorMutation(
  mutate: () => void,
  action: () => Promise<void>,
) {
  const snapshot = ROUTE_AUTHORIZATION_DESCRIPTORS.map((item) => ({ ...item }));
  try {
    mutate();
    await action();
  } finally {
    mutableDescriptors().splice(
      0,
      ROUTE_AUTHORIZATION_DESCRIPTORS.length,
      ...snapshot,
    );
  }
}

function mutableDescriptors() {
  return ROUTE_AUTHORIZATION_DESCRIPTORS as Array<
    (typeof ROUTE_AUTHORIZATION_DESCRIPTORS)[number]
  >;
}

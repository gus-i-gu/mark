# E_DDC_STAGE — Windows Authentication State Semantics

> Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
> Status: **ACTIVE SEMANTIC AUTHORITY**

Auth0 `successful login` means the provider verified the user. It does not prove callback delivery,
code exchange, usable client credentials, Device enrollment or synchronization. Markei may say
`authenticated` only after the waiting transaction returns non-empty, distinct and unexpired
access and ID tokens.

Materialize neutral closed states equivalent to:

- `callback-not-received`
- `callback-state-rejected`
- `authorization-code-exchange-rejected`
- `access-token-missing`
- `id-token-missing`
- `token-expired`
- `token-confusion-rejected`
- `provider-unavailable`
- `authentication-rejected-unknown`
- `authenticated`

Cancellation and user consent rejection remain intentional outcomes, not outages. Diagnostics must
not surface raw provider text or identity/security material. Successful correction wording is
limited to local callback/credential readiness and `provider-retest-required`; Device enrollment,
hosted convergence, MCG-02 closure and MCG-03 remain unclaimed.

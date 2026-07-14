# Introdução ao sistema `sketch_notebook`

O `sketch_notebook` é um sistema de organização para estudar, projetar e desenvolver software sem misturar tudo em uma só conversa ou arquivo.

A ideia central é simples:

**entender → implementar → validar → refatorar**

Ou seja: antes de mudar código, primeiro registramos o que entendemos; antes de decidir arquitetura, organizamos os conceitos; antes de “consertar rápido”, tentamos enxergar o sistema.

---

# Como usar, passo a passo

## 1. Comece pelo índice

Antes de qualquer trabalho, abra:

`documentation/sketch_notebook/INDEX.md`

Esse arquivo define a rota correta de leitura e diz quais arquivos devem ser consultados primeiro.

---

## 2. Identifique o tipo de conversa

Cada conversa tem uma função:

**[O] Operational Chat**
Cuida da execução prática: bugs, arquivos, testes, comandos, problemas concretos.

**[A] Didactic Chat**
Cuida do aprendizado: conceitos, glossário, explicações, termos técnicos.

**[D] Design Chat**
Cuida da arquitetura: estrutura, decisões, organização do sistema.

**[M] Main Chat**
Sintetiza tudo e decide o que vira material permanente.

---

## 3. Escreva apenas no arquivo correto

Cada função tem seu próprio arquivo temporário:

Operational escreve em:

`documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`

Didactic escreve em:

`documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`

Design escreve em:

`documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`

Esses arquivos são áreas de trabalho, não documentação final.

---

## 4. Use os Kanbans de conhecimento

Os conceitos são classificados por tipo:

`&&&` — Fundamentos de Ciência da Computação
Exemplo: classe, objeto, encapsulamento.

`&&%` — Conceitos específicos de Python
Exemplo: módulos, pacotes, `self`, `__init__`.

`&%%` — Arquitetura do projeto
Exemplo: RepositoryContract, ProductService, fluxo de registro.

`%%%` — Bibliotecas e dependências
Exemplo: sqlite3, pathlib, PySide6.

`&&` — conceitos temporários ainda não classificados.

---

## 5. Nunca misture rascunho com documentação permanente

Os arquivos `DEV_STAGE` servem para pensar, experimentar e organizar.

Depois, o Main Chat decide o que deve ser transferido para arquivos permanentes do `sketch_notebook`.

---

## 6. Registre decisões com contexto

Toda anotação útil deve tentar responder:

* Qual problema apareceu?
* Qual conceito foi necessário?
* Qual decisão foi tomada?
* O que ainda está incerto?
* Isso pertence a Operação, Didática ou Design?

---

## 7. Transforme debugging em aprendizado

Quando um erro aparece, ele não é só um erro.

Ele pode revelar:

* uma falha de arquitetura;
* um conceito Python mal entendido;
* uma dependência externa;
* uma regra de negócio;
* uma decisão de design ainda incompleta.

O objetivo é que cada correção aumente a compreensão do sistema.

---

# Regra prática

Antes de editar código, pergunte:

**“Eu sei qual conceito, arquivo e decisão estão envolvidos?”**

Se sim, prossiga.

Se não, registre primeiro no `DEV_STAGE` correto.


####

Initialize through PRI-O and run PMC-01, followed by PMC-02.

Initialize through PRI-A and run PMC-01, followed by PMC-02.

Initialize through PRI-D and run PMC-01, followed by PMC-02.

Run PDR-D from PROMPT_COLLECTION.md against the active branch. The task authorizes the Design permanent-document reconciliation and publication described by PDR-D.

---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.

# Arquitectura de Computadoras - Ensamblador MIPS 32

![MIPS32 Architecture](https://img.shields.io/badge/Architecture-MIPS32-blue.svg)
![Language](https://img.shields.io/badge/Language-Assembly-orange.svg)
![Simulator](https://img.shields.io/badge/Simulator-MARS%2FSPIM-green.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

Este repositorio contiene la colección completa de trabajos prácticos, ejercicios complementarios, modelos de exámenes finales y el trabajo práctico integrador final desarrollados en lenguaje ensamblador **MIPS 32** para la asignatura **Arquitectura de Computadoras**.

---

## 📌 Contenido del Repositorio

El repositorio se encuentra estructurado de manera modular sin espacios en rutas y ordenado por nivel de complejidad y temática:

```text
6-MIPS/
├── ejercicios_complementarios/     # Ejercicios temáticos de refuerzo
│   ├── carga_almacenamiento/      # Instrucciones de memoria (lw, sw, lb, sb)
│   ├── control_flujo/              # Bifurcaciones y saltos (beq, bne, j, jal)
│   ├── memoria_directivas/         # Directivas de ensamblador (.data, .word, .asciiz)
│   ├── operaciones_aritmeticas/    # Operaciones ALU (add, sub, mul, div)
│   ├── operaciones_logicas_bits/   # Operaciones a nivel de bit (and, or, xor, sll, srl)
│   └── guia_ejercicios_complementarios.pdf
├── practica_01/                    # Práctica 1: Fundamentos y ALU
│   ├── ejercicios/                 # Soluciones .asm (ejercicio_01 a 05)
│   └── guia_practica_01.pdf
├── practica_02/                    # Práctica 2: Control de flujo y Memoria
│   ├── ejercicios/                 # Soluciones .asm (ejercicio_01 a 05)
│   └── guia_practica_02.pdf
├── practica_03/                    # Práctica 3: Subrutinas, Pila y Vectores/Matrices
│   ├── ejercicios/                 # Soluciones .asm (ejercicio_01 a 08)
│   └── guia_practica_03.pdf
├── trabajo_practico/               # Trabajo Práctico Integrador Final
│   ├── consignas_tp_final.pdf
│   └── trabajo_practico_final.asm
└── finales/                        # Exámenes parciales, finales y ejercicios de repaso
    ├── ejercicios_adicionales/     # Algoritmos y resolución de ejercicios MIPS
    └── examenes/                   # Exámenes resueltos (Geometría, MCD, Matrices, Vectores, Pila)
```

---

## 🛠️ Requisitos e Instalación del Simulador

Para ensamblar y ejecutar los archivos `.asm` de este proyecto se recomienda utilizar el simulador **MARS** (MIPS Assembler and Runtime Simulator) o **QtSpim**.

### 1. MARS (Recomendado)
- **Requisito:** Tener instalado Java JRE 8 o superior.
- **Descarga:** [MARS Simulator (Java JAR)](https://courses.missouri.edu/marssim/)
- **Ejecución por interfaz gráfica:**
  ```bash
  java -jar Mars4_5.jar
  ```
- **Ejecución desde línea de comandos:**
  ```bash
  java -jar Mars4_5.jar nc trabajo_practico/trabajo_practico_final.asm
  ```

### 2. QtSpim / SPIM
- **Descarga:** [QtSpim SourceForge](https://sourceforge.net/projects/spimsimulator/)

---

## 🧠 Conceptos Desarrollados

### 1. Conjunto de Instrucciones y Registros MIPS 32
- **Registros de Uso General:** `$zero` (`$0`), `$v0-$v1` (retorno de valores/syscalls), `$a0-$a3` (argumentos), `$t0-$t9` (temporales), `$s0-$s7` (guardados), `$sp` (puntero de pila), `$ra` (dirección de retorno).
- **Instrucciones ALU:** `add`, `addi`, `sub`, `mul`, `div`, `and`, `andi`, `or`, `ori`, `xor`, `sll`, `srl`.

### 2. Carga y Almacenamiento en Memoria
- Directivas `.data`, `.text`, `.word`, `.half`, `.byte`, `.asciiz`, `.space`.
- Transferencia de datos mediante `lw` (load word), `sw` (store word), `lb` (load byte), `sb` (store byte).

### 3. Control de Flujo y Subrutinas
- Saltos condicionales `beq` (branch if equal), `bne` (branch if not equal), `slt` (set on less than).
- Llamada a procedimientos mediante `jal` (jump and link) y retorno con `jr $ra`.
- Preservación de registros en la memoria Pila (`Stack`) usando `$sp`.

### 4. Algoritmos y Estructuras de Datos Avanzadas
- Operaciones con arreglos (vectores) y matrices bidimensionales (cálculo de offset fila/columna).
- Operaciones matriciales: Transpuesta, Producto Punto, Multiplicación de Matrices, Matriz Identidad, Diagonal.
- Algoritmos matemáticos: Máximo Común Divisor (MCD), Fibonacci, Estadísticas y Máximos/Mínimos.

---

## 💻 Llamadas al Sistema (`Syscalls` en MARS)

En MARS se utiliza `$v0` para especificar el servicio solicitado y `$a0` / `$f12` para los argumentos:

| Servicio | Código (`$v0`) | Argumentos / Entrada | Resultado / Salida |
| :--- | :---: | :--- | :--- |
| **Imprimir Entero** | `1` | `$a0` = Entero a imprimir | Salida en consola |
| **Imprimir Cadena** | `4` | `$a0` = Dirección del string (`.asciiz`) | Salida en consola |
| **Leer Entero** | `5` | - | Entero retornado en `$v0` |
| **Leer Cadena** | `8` | `$a0` = Buffer, `$a1` = Longitud máx | Escribe en buffer |
| **Finalizar Programa** | `10` | - | Detiene la ejecución |

---

## 🚀 Uso Rápido

1. Clona el repositorio:
   ```bash
   git clone https://github.com/nicobacalini/mips32.git
   cd mips32
   ```
2. Abre MARS y carga cualquier archivo `.asm` (por ejemplo `trabajo_practico/trabajo_practico_final.asm`).
3. Presiona **Assemble** (`F3`) y luego **Run** (`F5`).

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia MIT. Siéntete libre de utilizar estos ejercicios para fines de aprendizaje y referencia académica.

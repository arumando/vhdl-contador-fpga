# ⚡ Contadores digitales en VHDL para FPGA

Dos circuitos lógicos secuenciales descritos en **VHDL** e implementados en una **FPGA Xilinx Artix-7**. Muestran un conteo de **00 a 99** en dos **displays de 7 segmentos multiplexados**.

> Contexto: [PENDIENTE: materia, semestre y si fue trabajo individual o en equipo]

## 📦 Diseños

### 1. `contador-00-99/`: contador ascendente con pausa

| Puerto | Dirección | Función |
|---|---|---|
| `clk` | entrada | Reloj de la tarjeta |
| `reset` | entrada (switch) | Regresa el conteo a `00` |
| `hold` | entrada (switch) | Pausa el conteo mientras está en `1` |
| `dato[3:0]` | salida (LEDs) | Unidades en binario |
| `datoSeg[6:0]` | salida | Segmentos del display (activos en bajo) |
| `controlSeg[7:0]` | salida | Selección del display encendido (unidades / decenas) |

Funcionamiento: un **divisor de frecuencia** genera un pulso aproximadamente cada segundo; las **unidades** cuentan de 0 a 9 y, al pasar de 9 a 0, incrementan las **decenas**. Un segundo divisor alterna rápidamente entre los dos displays (multiplexado), de modo que ambos dígitos se ven encendidos al mismo tiempo.

### 2. `contador-ascendente-descendente/`: contador con carga y cambio de dirección

Incluye todo lo anterior y agrega:

| Puerto | Función |
|---|---|
| `updown` | `1` = cuenta hacia arriba (00→99), `0` = hacia abajo (99→00) |
| `load` | Carga un valor inicial desde los switches |
| `datoload[7:0]` | Valor a cargar en BCD: bits `7..4` decenas, bits `3..0` unidades |

Al cambiar de dirección, el conteo **continúa desde el número actual** (cada contador copia el valor del otro). El decodificador también muestra los dígitos `A`–`F` si se carga un valor que no es BCD.

## 🛠️ Tecnologías

- **VHDL** (IEEE `STD_LOGIC_1164` y `NUMERIC_STD`)
- **Xilinx Vivado**
- FPGA **Artix-7 `xc7a100tcsg324-1`**
- Tarjeta de desarrollo: [PENDIENTE: nombre de la tarjeta usada]
- Restricciones de pines en archivos `.xdc`

## ▶️ Cómo ejecutarlo

1. Abre **Vivado** → *Create Project* → *RTL Project*.
2. Selecciona la parte **`xc7a100tcsg324-1`** (o la tarjeta correspondiente).
3. *Add Sources*: agrega el `.vhd` de la carpeta del diseño que quieres probar.
4. *Add Constraints*: agrega el `pines.xdc` de la misma carpeta.
   - Si tu tarjeta es diferente, ajusta los `PACKAGE_PIN` según su manual.
5. *Run Synthesis* → *Run Implementation* → *Generate Bitstream*.
6. *Open Hardware Manager* → *Auto Connect* → *Program Device*.
7. Usa los switches `reset`, `hold`, `load` y `updown` para probar el circuito.

## 📸 Capturas

[PENDIENTE: foto de la FPGA mostrando el conteo en los displays]

[PENDIENTE: captura del esquemático RTL generado por Vivado]

[PENDIENTE: captura de la simulación (forma de onda)]

## 📚 Qué aprendí

<!-- Revisa esta lista y escríbela con tus propias palabras. -->
- Describir hardware secuencial en VHDL con procesos sincronizados al reloj.
- Construir divisores de frecuencia a partir del reloj de la tarjeta.
- Multiplexar displays de 7 segmentos y decodificar BCD a segmentos.
- Asignar pines físicos con archivos de restricciones `.xdc`.
- Pasar de la descripción en código a un circuito real: síntesis, implementación y programación de la FPGA.

## 🚀 Posibles mejoras

- **Divisor exacto de 1 segundo:** los contadores `contador` y `contadorms` nunca se reinician al llegar a su valor máximo. En síntesis se desbordan hasta la siguiente potencia de 2 (por ejemplo, 2²⁷ ciclos ≈ 1.34 s con un reloj de 100 MHz, en lugar de 1 s). Reiniciarlos a `0` al llegar a `99_999_999` daría el segundo exacto.
- Agregar un *testbench* para simular el diseño en Vivado.
- Agregar un circuito antirrebote (*debounce*) para botones.

## 👤 Autor

**José Armando García Bandera** — [github.com/arumando](https://github.com/arumando)

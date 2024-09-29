Please click or download the file name : report.pdf to read the project

課程 : 積體電路設計(Integrated circuits)

開設校系 : 台大電機

授課教授 : 闕志達 教授

修習年度 : 112-1

Problem Specification
Design a circuit with reset that computes the approximation of the sigmoid function. There are two input signals for the circuit, i.e., i_x with 8 bits, and a 1-bit i_in_valid. The i_x is a fixed-point format with a 1-bit sign, 2-bit integer, and 5-bit fraction. The circuit contains two output signals, i.e., up to 16-bit o_y for the approximation output value, and a 1-bit o_out_valid. The o_y is a fixed-point format with 1-bit integer and up to 15-bit fraction, and you don't need to use all 15 bits for your design's output. Note that the input signal is signed, and the output signal is unsigned. The relation between the input and the output signals is

Y = sigmoid(x) = 1/(1+e^(-x))

You are encouraged to use piecewise-linear approximation to design your circuit. For example, Figure 1 uses three segments to approximate the real function, while Figure 2 uses 5 segments. Figure 2 is more accurate than Figure 1, but its cost is using more transistors in the circuit because it needs to calculate more slopes. This is a tradeoff, so it is important to think about what your approximation function is before designing the circuit. Note that this homework only considers the range of [-4, 4).The following diagram illustrates the relation between your design and the testbench. Pull up “o_out_valid” and output your answer to “o_y[15:0]” once your circuit finishes the calculation, the testbench will then check your answers. Note that the output signals: “o_y[15:0]” and “o_out_valid” must be registered, i.e., they are outputs of DFFs


Design Rules


Those who do not design according to the following rules will not be graded.

➢ LUT-based designs are not allowed.


➢ There should be a reset signal for the register.


➢ You are free to add pipeline registers.


➢ You can loosen your simulation timing first, (i.e., `define CYCLE XXXX in the tb.v), then shorten the clock period to find your critical path.


➢ Your design should be based on the standard cells in the lib.v. All logic operations in your design MUST consist of the standard cells instead of using the operands such as “+”, “-”, “&”, “|”, “>”, and “<”.


➢ Using “assign” to concatenate signals or specify constant values is allowed.


➢ Design your homework in the given “sigmoid.v” file. You are NOT ALLOWED to change the filename and the header of the top module (i.e. the module name and the I/O ports).


➢ If your design contains more than one module, don’t create a new file for them, just put those modules in “sigmoid.v.”

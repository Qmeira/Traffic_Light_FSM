module traffic_light (
    input  logic clk,    // The heartbeat of the circuit 
    input  logic reset,  // Resets the FSM to the start (S0) 
    input  logic TAORB,  // Traffic Sensor 
    output logic [2:0] light_A, // 3 bits: [Red, Yellow, Green] 
    output logic [2:0] light_B
);

// State Encoding
typedef enum logic [1:0] {
    S0 = 2'b00, // LA: Green,  LB: Red
    S1 = 2'b01, // LA: Yellow, LB: Red (Timed)
    S2 = 2'b10, // LA: Red,    LB: Green
    S3 = 2'b11  // LA: Red,    LB: Yellow (Timed)
} state_t;

state_t current_state, next_state;
logic [3:0] timer; // Internal counter to count up to 5

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= S0;
        timer <= 0; 
    end else begin
        current_state <= next_state;
        // Increment timer in yellow states, otherwise reset it 
        if (current_state == S1 || current_state == S3)
            timer <= timer + 1;
        else
            timer <= 0;
    end
end

always_comb begin
    next_state = current_state; // Default: stay in current state
    case (current_state)
        S0: if (~TAORB) next_state = S1; // Move if Street B has traffic 
        S1: if (timer >= 4) next_state = S2; // Wait 5 units then move 
        S2: if (TAORB) next_state = S3; // Move if Street A has traffic 
        S3: if (timer >= 4) next_state = S0; // Wait 5 units then move
    endcase
end

always_comb begin
    case (current_state)
        // Light Format: 3'b[Red][Yellow][Green]
        S0: {light_A, light_B} = {3'b001, 3'b100}; // A: Green, B: Red 
        S1: {light_A, light_B} = {3'b010, 3'b100}; // A: Yellow, B: Red 
        S2: {light_A, light_B} = {3'b100, 3'b001}; // A: Red, B: Green 
        S3: {light_A, light_B} = {3'b100, 3'b010}; // A: Red, B: Yellow 
        default: {light_A, light_B} = {3'b100, 3'b100}; // Safe state: both Red
    endcase
end
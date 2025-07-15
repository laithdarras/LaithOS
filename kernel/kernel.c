void kernel_main() {
    char* video_memory = (char*)0xb8000; // Video memory address for text mode
    const char* message = "Hello, LaithOS!";
    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];      // Character
        video_memory[i * 2 + 1] = 0x07;        // Attribute byte (light gray on black)
    }
}
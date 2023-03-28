@path=C:\Program Files\NASM
@nasm bootloader.asm -f bin -o bootloader.bin
@nasm extended.asm -f bin -o extended.bin
@copy/b bootloader.bin+extended.bin LightMode.img
@pause
@exit/b
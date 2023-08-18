# DemoMGJ
...

## Pasos para actualizar repositorio

> Si es primera vez, tienes que configurar tu usuario en la terminal.

1. Configurar el git de terminal:
    1. Agregas tu nombre de usuario con el siguiente comando: 
    ```console
    > git config --global user.name "TU_USERNAME"
    ```
    2. Agregas el email con el siguiente:
    ```console
    > git config --global user.email "TU_EMAIL"
    ```
2. Descargas repositorio.

3. Modificas lo que vayas a modificar.

> Te ubicas en la carpeta del proyecto desde la terminal.
4. Agregas los archivos modificados con el siguiente comando:
> Si vas agregar la actualización de todos los archivos del repositorio, colocas este comando:
```console
> git add .
```
> Si solo vas agregar la modificación de un archivo, colocas este comando:
```console
> git add ./ARCHIVO
```
5. Con el siguiente comando agregas una muy breve descripción de la modificación que le hiciste al archivo:
```console
> git commit -m "MENSAJE"
```
3. Y para subir las modificaciones, colocas el siguiente comando:
```console
> git push origin main
```
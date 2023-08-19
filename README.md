# DemoMGJ
...

## TO-DO relacionado con la estructura del proyecto

> * Se usa snake_case para los nombres de las carpetas y archivos
> * Se usa PascalCase para los nombre de los nodos
> * Y en general, para recursos de terceros, agregarlos a la carpeta _addons/_

- [ ] Actualizar las referencias de cada archivo utilizado dentro del godot con su nueva ubicación
- [ ] Eliminar las carpetas y documentos que no sean necesarias una vez ya descartadas, como los recursos de prueba como "FreeCuteTileset", "legacy fantasy high forest" "monstardt tree"
- [ ] Organizar todos los archivos _.tscn_ en su respectiva carpeta
- [x] Organizar todos los scripts en carpetas con su respectiva carpeta

## Pasos para actualizar repositorio desde terminal

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
3. Y para subir las modificaciones a la branch principal, colocas el siguiente comando:
```console
> git push origin main
```

### Pasos para importar los cambios del repositorio remoto al local
...
### Estructura del proyecto
...
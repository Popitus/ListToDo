# Lista de Tareas en SwiftUI con SwiftData

Este proyecto es un MVP (Producto Mínimo Viable) de una aplicación de lista de tareas mejorado, utilizando una arquitectura que incorpora algunos conceptos de Clean Architecture y SOLID.

## Descripción

Esta aplicación de lista de tareas ha sido mejorada para seguir principios de diseño de software sólidos, incluyendo el uso de un repositorio, casos de uso y la implementación de los repositorios mediante protocolos. También hace uso de mappers para convertir entre modelos de datos internos y entidades de la interfaz de usuario.

## Características

- **Agregar Tareas:** Los usuarios pueden agregar nuevas tareas mediante un formulario de entrada.
- **Marcar y Desmarcar Tareas:** Las tareas se pueden marcar o desmarcar como completadas.
- **Eliminar Tareas:** Las tareas se pueden eliminar fácilmente desde la lista.
- **Detalles de Tarea Mejorados:** Se proporciona una vista detallada para cada tarea, que incluye descripción, fecha de vencimiento, prioridad, etc.

## Arquitectura y Tecnologías Utilizadas

- **Repositorio y Casos de Uso:** Se implementa un repositorio para abstraer el acceso a los datos y casos de uso para la lógica empresarial.
- **Protocolos y Mappers:** Los repositorios se implementan mediante protocolos, lo que permite una fácil sustitución y pruebas. Se utilizan mappers para convertir entre modelos de datos internos y entidades de la interfaz de usuario.
- **Swiftdata:** La persistencia de datos se realiza utilizando SwiftData.

## Estructura del Proyecto

El proyecto sigue una estructura clara y organizada, con separación de responsabilidades entre las capas de presentación, dominio y datos.

## Ejecución

1. Clona este repositorio.
2. Abre el proyecto en Xcode.
3. Ejecuta la aplicación en el simulador de iOS o en un dispositivo físico.

## Contribuciones

Las contribuciones son bienvenidas. Si encuentras algún problema o tienes una mejora, no dudes en abrir un problema o enviar un pull request. 

## Notas Adicionales

Este proyecto se ha creado con el objetivo de demostrar una implementación mejorada de un MVP utilizando SwiftUI y las mejores prácticas de desarrollo de software. No tiene un valor comercial como tal, solo es a modo de práctica e ilustrativo.

## Autor

Oliver R.C.

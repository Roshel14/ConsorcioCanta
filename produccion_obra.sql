-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2024 a las 20:37:38
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `produccion_obra`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_expediente`
--

CREATE TABLE `actividad_expediente` (
  `actividad_expediente_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `area_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `asistencia_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consumo_materiales`
--

CREATE TABLE `consumo_materiales` (
  `consumo_id` int(11) NOT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `cantidad_utilizada` decimal(10,2) DEFAULT NULL,
  `unidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consumo_materiales`
--

INSERT INTO `consumo_materiales` (`consumo_id`, `tarea_id`, `material_id`, `cantidad_utilizada`, `unidad_id`) VALUES
(1, 1, 2, 20.00, 2),
(2, 1, 1, 50.00, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_tareas`
--

CREATE TABLE `historial_tareas` (
  `historial_id` int(11) NOT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `cambio_fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `descripcion_cambio` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kpi`
--

CREATE TABLE `kpi` (
  `kpi_id` int(11) NOT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `kpi_descripcion` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `material_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`material_id`, `nombre`, `precio_unitario`, `created_at`, `unidad_id`) VALUES
(1, 'ladrillo', 5.00, '2024-11-12 04:01:34', 2),
(2, 'cemento', 25.00, '2024-11-12 04:01:34', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion_diaria`
--

CREATE TABLE `produccion_diaria` (
  `produccion_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `horas_trabajadas` decimal(5,2) NOT NULL,
  `unidades_producidas` int(11) DEFAULT NULL,
  `costo_mano_obra` decimal(10,2) DEFAULT NULL,
  `costo_materiales` decimal(10,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `unidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `reporte_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tarea_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `horas_trabajadas` decimal(5,2) DEFAULT NULL,
  `tareas_completadas` int(11) DEFAULT NULL,
  `unidades_producidas` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `nombre`, `descripcion`) VALUES
(1, 'Operario', 'Responsable del área'),
(2, 'Peon', 'Asiste en las actividades del area'),
(3, 'supervisor', 'supervisor de la produccion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `tarea_id` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `asignado_a` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  `estado` enum('pendiente','en progreso','completada') DEFAULT 'pendiente',
  `tiempo_estimado` decimal(5,2) DEFAULT NULL,
  `unidades_estimadas` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `unidad_medida` varchar(20) DEFAULT NULL,
  `unidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`tarea_id`, `descripcion`, `fecha_inicio`, `fecha_fin`, `asignado_a`, `area_id`, `tipo_id`, `estado`, `tiempo_estimado`, `unidades_estimadas`, `created_at`, `updated_at`, `unidad_medida`, `unidad_id`) VALUES
(1, 'construcción de piso concreto de 90 m2', '2024-11-11', '2024-11-12', 5, NULL, 1, 'pendiente', 32.00, 90, '2024-11-11 06:08:46', '2024-11-11 06:08:46', '90', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifas_mano_obra`
--

CREATE TABLE `tarifas_mano_obra` (
  `tarifa_id` int(11) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tarifa_hora` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarifas_mano_obra`
--

INSERT INTO `tarifas_mano_obra` (`tarifa_id`, `rol_id`, `user_id`, `tarifa_hora`, `created_at`) VALUES
(1, 1, NULL, 15.00, '2024-11-12 02:53:59'),
(2, 2, NULL, 12.00, '2024-11-12 02:53:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_actividades`
--

CREATE TABLE `tipos_actividades` (
  `tipo_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `actividad_expediente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_actividades`
--

INSERT INTO `tipos_actividades` (`tipo_id`, `nombre`, `descripcion`, `actividad_expediente_id`) VALUES
(1, 'Construcción de Almacén', 'Techado, perímetro y piso', NULL),
(2, 'Desmontaje', 'Desmontaje de puertas y ventanas', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadores_tareas`
--

CREATE TABLE `trabajadores_tareas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tarea_id` int(11) NOT NULL,
  `fecha_asignacion` date DEFAULT curdate(),
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajadores_tareas`
--

INSERT INTO `trabajadores_tareas` (`id`, `user_id`, `tarea_id`, `fecha_asignacion`, `rol_id`) VALUES
(1, 3, 1, '2024-11-11', 1),
(2, 4, 1, '2024-11-11', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_medida`
--

CREATE TABLE `unidades_medida` (
  `unidad_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `abreviatura` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidades_medida`
--

INSERT INTO `unidades_medida` (`unidad_id`, `nombre`, `abreviatura`) VALUES
(1, 'metros cuadrados', 'm2'),
(2, 'unidades', 'und'),
(3, 'pulgadas', 'pg'),
(4, 'metro cubico', 'm3'),
(5, 'kilogramo', 'kg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `user_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(250) NOT NULL,
  `dni` int(8) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`user_id`, `nombre`, `apellido`, `dni`, `direccion`, `rol_id`, `email`, `password`, `created_at`, `updated_at`) VALUES
(3, 'Obdulio Landa', '', 0, '', 1, 'obdulio@example.com', '123', '2024-11-11 03:40:09', '2024-11-11 03:40:09'),
(4, 'Robert', '', 0, '', 2, 'robert@example.com', '1234', '2024-11-11 03:40:09', '2024-11-11 03:40:09'),
(5, 'elvis sanchez paredes', '', 0, '', 3, 'elvis@hotmail.com', '123', '2024-11-11 05:52:47', '2024-11-11 05:52:47'),
(7, 'roger', '', 0, '', 1, 'roger@gmail.com', '123', '2024-11-20 18:25:37', '2024-11-20 18:25:37');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividad_expediente`
--
ALTER TABLE `actividad_expediente`
  ADD PRIMARY KEY (`actividad_expediente_id`);

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`area_id`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`asistencia_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `consumo_materiales`
--
ALTER TABLE `consumo_materiales`
  ADD PRIMARY KEY (`consumo_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `material_id` (`material_id`),
  ADD KEY `unidad_id` (`unidad_id`);

--
-- Indices de la tabla `historial_tareas`
--
ALTER TABLE `historial_tareas`
  ADD PRIMARY KEY (`historial_id`),
  ADD KEY `tarea_id` (`tarea_id`);

--
-- Indices de la tabla `kpi`
--
ALTER TABLE `kpi`
  ADD PRIMARY KEY (`kpi_id`),
  ADD KEY `tarea_id` (`tarea_id`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `unidad_id` (`unidad_id`);

--
-- Indices de la tabla `produccion_diaria`
--
ALTER TABLE `produccion_diaria`
  ADD PRIMARY KEY (`produccion_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `unidad_id` (`unidad_id`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`reporte_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`tarea_id`),
  ADD KEY `asignado_a` (`asignado_a`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `tipo_id` (`tipo_id`),
  ADD KEY `unidad_id` (`unidad_id`);

--
-- Indices de la tabla `tarifas_mano_obra`
--
ALTER TABLE `tarifas_mano_obra`
  ADD PRIMARY KEY (`tarifa_id`),
  ADD KEY `rol_id` (`rol_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `tipos_actividades`
--
ALTER TABLE `tipos_actividades`
  ADD PRIMARY KEY (`tipo_id`),
  ADD KEY `actividad_expediente_id` (`actividad_expediente_id`);

--
-- Indices de la tabla `trabajadores_tareas`
--
ALTER TABLE `trabajadores_tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tarea_id` (`tarea_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `unidades_medida`
--
ALTER TABLE `unidades_medida`
  ADD PRIMARY KEY (`unidad_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividad_expediente`
--
ALTER TABLE `actividad_expediente`
  MODIFY `actividad_expediente_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `asistencia_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consumo_materiales`
--
ALTER TABLE `consumo_materiales`
  MODIFY `consumo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `historial_tareas`
--
ALTER TABLE `historial_tareas`
  MODIFY `historial_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kpi`
--
ALTER TABLE `kpi`
  MODIFY `kpi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `produccion_diaria`
--
ALTER TABLE `produccion_diaria`
  MODIFY `produccion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `reporte_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `tarea_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tarifas_mano_obra`
--
ALTER TABLE `tarifas_mano_obra`
  MODIFY `tarifa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipos_actividades`
--
ALTER TABLE `tipos_actividades`
  MODIFY `tipo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `trabajadores_tareas`
--
ALTER TABLE `trabajadores_tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `unidades_medida`
--
ALTER TABLE `unidades_medida`
  MODIFY `unidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `consumo_materiales`
--
ALTER TABLE `consumo_materiales`
  ADD CONSTRAINT `consumo_materiales_ibfk_1` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `consumo_materiales_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materiales` (`material_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `consumo_materiales_ibfk_3` FOREIGN KEY (`unidad_id`) REFERENCES `unidades_medida` (`unidad_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `historial_tareas`
--
ALTER TABLE `historial_tareas`
  ADD CONSTRAINT `historial_tareas_ibfk_1` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `kpi`
--
ALTER TABLE `kpi`
  ADD CONSTRAINT `kpi_ibfk_1` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD CONSTRAINT `materiales_ibfk_1` FOREIGN KEY (`unidad_id`) REFERENCES `unidades_medida` (`unidad_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `produccion_diaria`
--
ALTER TABLE `produccion_diaria`
  ADD CONSTRAINT `produccion_diaria_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `produccion_diaria_ibfk_2` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `produccion_diaria_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `produccion_diaria_ibfk_4` FOREIGN KEY (`unidad_id`) REFERENCES `unidades_medida` (`unidad_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reportes_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`asignado_a`) REFERENCES `usuarios` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tareas_ibfk_3` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_actividades` (`tipo_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tareas_ibfk_4` FOREIGN KEY (`unidad_id`) REFERENCES `unidades_medida` (`unidad_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tarifas_mano_obra`
--
ALTER TABLE `tarifas_mano_obra`
  ADD CONSTRAINT `tarifas_mano_obra_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tarifas_mano_obra_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tipos_actividades`
--
ALTER TABLE `tipos_actividades`
  ADD CONSTRAINT `tipos_actividades_ibfk_1` FOREIGN KEY (`actividad_expediente_id`) REFERENCES `actividad_expediente` (`actividad_expediente_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `trabajadores_tareas`
--
ALTER TABLE `trabajadores_tareas`
  ADD CONSTRAINT `trabajadores_tareas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trabajadores_tareas_ibfk_2` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`tarea_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `trabajadores_tareas_ibfk_3` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

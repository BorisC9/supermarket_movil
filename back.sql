--
-- PostgreSQL database dump
--

\restrict 1CsAdjhWRkR3uLm84lPCk58bJjQaRASdBqlCDXUApE4mmHsk5Djge8BUFM3gllj

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-12-10 22:09:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 305 (class 1255 OID 18559)
-- Name: fn_actualizar_acceso_usuario(integer, integer, character varying, timestamp without time zone, integer, character varying, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_acceso_usuario(p_ide_acce integer, p_ide_cuen integer, p_navegador_acce character varying, p_fecha_acce timestamp without time zone, p_num_int_fall_acce integer, p_ip_acce character varying, p_latitud_acce numeric DEFAULT NULL::numeric, p_longitud_acce numeric DEFAULT NULL::numeric, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE acceso_usuario SET
        ide_cuen = p_ide_cuen,
        navegador_acce = p_navegador_acce,
        fecha_acce = p_fecha_acce,
        num_int_fall_acce = p_num_int_fall_acce,
        ip_acce = p_ip_acce,
        latitud_acce = p_latitud_acce,
        longitud_acce = p_longitud_acce
    WHERE ide_acce = p_ide_acce;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Acceso de usuario actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_acceso_usuario(p_ide_acce integer, p_ide_cuen integer, p_navegador_acce character varying, p_fecha_acce timestamp without time zone, p_num_int_fall_acce integer, p_ip_acce character varying, p_latitud_acce numeric, p_longitud_acce numeric, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 325 (class 1255 OID 18560)
-- Name: fn_actualizar_categoria(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_categoria(p_ide_cate integer, p_nombre_cate character varying, p_descripcion_cate character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE categoria SET
        nombre_cate = p_nombre_cate,
        descripcion_cate = p_descripcion_cate,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_cate = p_ide_cate;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Categoría actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_categoria(p_ide_cate integer, p_nombre_cate character varying, p_descripcion_cate character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 394 (class 1255 OID 18561)
-- Name: fn_actualizar_cliente(integer, character varying, date, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_cliente(p_ide_clie integer, p_cedula_clie character varying, p_fecha_nacimiento_clie date, p_edad_clie integer, p_telefono_clie character varying, p_primer_nombre_clie character varying, p_apellido_paterno_clie character varying, p_email_clie character varying, p_es_socio character varying, p_es_tercera_edad character varying, p_segundo_nombre_clie character varying DEFAULT NULL::character varying, p_apellido_materno_clie character varying DEFAULT NULL::character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cliente SET
        cedula_clie = p_cedula_clie,
        fecha_nacimiento_clie = p_fecha_nacimiento_clie,
        edad_clie = p_edad_clie,
        telefono_clie = p_telefono_clie,
        primer_nombre_clie = p_primer_nombre_clie,
        apellido_paterno_clie = p_apellido_paterno_clie,
        email_clie = p_email_clie,
        es_socio = p_es_socio,
        es_tercera_edad = p_es_tercera_edad,
        segundo_nombre_clie = p_segundo_nombre_clie,
        apellido_materno_clie = p_apellido_materno_clie,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_clie = p_ide_clie;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cliente actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_cliente(p_ide_clie integer, p_cedula_clie character varying, p_fecha_nacimiento_clie date, p_edad_clie integer, p_telefono_clie character varying, p_primer_nombre_clie character varying, p_apellido_paterno_clie character varying, p_email_clie character varying, p_es_socio character varying, p_es_tercera_edad character varying, p_segundo_nombre_clie character varying, p_apellido_materno_clie character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 18562)
-- Name: fn_actualizar_cuenta(integer, integer, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_cuenta(p_ide_cuen integer, p_ide_empl integer, p_ide_perf integer, p_usuario_cuen character varying, p_password_cuen character varying, p_estado_cuen character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cuenta SET
        ide_empl = p_ide_empl,
        ide_perf = p_ide_perf,
        usuario_cuen = p_usuario_cuen,
        password_cuen = p_password_cuen,
        estado_cuen = p_estado_cuen,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_cuen = p_ide_cuen;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cuenta actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_cuenta(p_ide_cuen integer, p_ide_empl integer, p_ide_perf integer, p_usuario_cuen character varying, p_password_cuen character varying, p_estado_cuen character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 18563)
-- Name: fn_actualizar_detalle_entrega(integer, integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_detalle_entrega(p_ide_deta_entr integer, p_ide_entr integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE detalle_entrega SET
        ide_entr = p_ide_entr,
        ide_prod = p_ide_prod,
        cantidad_prod = p_cantidad_prod,
        precio_unitario_prod = p_precio_unitario_prod,
        dcto_prod = p_dcto_prod,
        iva_prod = p_iva_prod,
        subtotal_prod = p_subtotal_prod
    WHERE ide_deta_entr = p_ide_deta_entr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de entrega actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_detalle_entrega(p_ide_deta_entr integer, p_ide_entr integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 338 (class 1255 OID 18564)
-- Name: fn_actualizar_detalle_pedido(integer, integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_detalle_pedido(p_ide_deta_pedi integer, p_ide_pedi integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE detalle_pedido SET
        ide_pedi = p_ide_pedi,
        ide_prod = p_ide_prod,
        cantidad_prod = p_cantidad_prod,
        precio_unitario_prod = p_precio_unitario_prod,
        dcto_prod = p_dcto_prod,
        iva_prod = p_iva_prod,
        subtotal_prod = p_subtotal_prod
    WHERE ide_deta_pedi = p_ide_deta_pedi;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de pedido actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_detalle_pedido(p_ide_deta_pedi integer, p_ide_pedi integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 319 (class 1255 OID 18565)
-- Name: fn_actualizar_detalle_venta(integer, integer, integer, integer, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_detalle_venta(p_ide_deta_vent integer, p_ide_vent integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_dcto_promo numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE detalle_venta SET
        ide_vent = p_ide_vent,
        ide_prod = p_ide_prod,
        cantidad_prod = p_cantidad_prod,
        precio_unitario_prod = p_precio_unitario_prod,
        dcto_prod = p_dcto_prod,
        dcto_promo = p_dcto_promo,
        iva_prod = p_iva_prod,
        subtotal_prod = p_subtotal_prod
    WHERE ide_deta_vent = p_ide_deta_vent;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de venta actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_detalle_venta(p_ide_deta_vent integer, p_ide_vent integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_dcto_promo numeric, p_iva_prod numeric, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 349 (class 1255 OID 18566)
-- Name: fn_actualizar_empleado(integer, integer, character varying, date, integer, date, character varying, character varying, numeric, character varying, character varying, character varying, character varying, date, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_empleado(p_ide_empl integer, p_ide_rol integer, p_cedula_empl character varying, p_fecha_nacimiento_empl date, p_edad_empl integer, p_fecha_inicio_empl date, p_primer_nombre_empl character varying, p_apellido_paterno_empl character varying, p_rmu_empl numeric, p_titulo_empl character varying, p_estado_empl character varying, p_segundo_nombre_empl character varying DEFAULT NULL::character varying, p_apellido_materno_empl character varying DEFAULT NULL::character varying, p_fecha_termino_empl date DEFAULT NULL::date, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE empleado SET
        ide_rol = p_ide_rol,
        cedula_empl = p_cedula_empl,
        fecha_nacimiento_empl = p_fecha_nacimiento_empl,
        edad_empl = p_edad_empl,
        fecha_inicio_empl = p_fecha_inicio_empl,
        primer_nombre_empl = p_primer_nombre_empl,
        apellido_paterno_empl = p_apellido_paterno_empl,
        rmu_empl = p_rmu_empl,
        titulo_empl = p_titulo_empl,
        estado_empl = p_estado_empl,
        segundo_nombre_empl = p_segundo_nombre_empl,
        apellido_materno_empl = p_apellido_materno_empl,
        fecha_termino_empl = p_fecha_termino_empl,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_empl = p_ide_empl;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empleado actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_empleado(p_ide_empl integer, p_ide_rol integer, p_cedula_empl character varying, p_fecha_nacimiento_empl date, p_edad_empl integer, p_fecha_inicio_empl date, p_primer_nombre_empl character varying, p_apellido_paterno_empl character varying, p_rmu_empl numeric, p_titulo_empl character varying, p_estado_empl character varying, p_segundo_nombre_empl character varying, p_apellido_materno_empl character varying, p_fecha_termino_empl date, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 329 (class 1255 OID 18567)
-- Name: fn_actualizar_empresa(integer, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_empresa(p_ide_empr integer, p_nombre_empr character varying, p_responsable_empr character varying, p_fecha_contrato_empr timestamp without time zone, p_direccion_empr character varying, p_telefono_empr character varying, p_email_empr character varying, p_estado_empr character varying, p_descripcion_empr character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE empresa SET
        nombre_empr = p_nombre_empr,
        responsable_empr = p_responsable_empr,
        fecha_contrato_empr = p_fecha_contrato_empr,
        direccion_empr = p_direccion_empr,
        telefono_empr = p_telefono_empr,
        email_empr = p_email_empr,
        estado_empr = p_estado_empr,
        descripcion_empr = p_descripcion_empr,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_empr = p_ide_empr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empresa actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_empresa(p_ide_empr integer, p_nombre_empr character varying, p_responsable_empr character varying, p_fecha_contrato_empr timestamp without time zone, p_direccion_empr character varying, p_telefono_empr character varying, p_email_empr character varying, p_estado_empr character varying, p_descripcion_empr character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 307 (class 1255 OID 18568)
-- Name: fn_actualizar_empresa_precios(integer, integer, integer, numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_empresa_precios(p_ide_empr_prod integer, p_ide_empr integer, p_ide_prod integer, p_precio_compra_prod numeric, p_dcto_compra_prod numeric, p_dcto_caducidad_prod numeric, p_iva_prod numeric, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE empresa_precios SET
        ide_empr = p_ide_empr,
        ide_prod = p_ide_prod,
        precio_compra_prod = p_precio_compra_prod,
        dcto_compra_prod = p_dcto_compra_prod,
        dcto_caducidad_prod = p_dcto_caducidad_prod,
        iva_prod = p_iva_prod,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_empr_prod = p_ide_empr_prod;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Precio de empresa actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_empresa_precios(p_ide_empr_prod integer, p_ide_empr integer, p_ide_prod integer, p_precio_compra_prod numeric, p_dcto_compra_prod numeric, p_dcto_caducidad_prod numeric, p_iva_prod numeric, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 18569)
-- Name: fn_actualizar_entrega(integer, integer, integer, timestamp without time zone, integer, numeric, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_entrega(p_ide_entr integer, p_ide_pedi integer, p_ide_prov integer, p_fecha_entr timestamp without time zone, p_cantidad_total_entr integer, p_total_entr numeric, p_estado_entr character varying, p_observacion_entr character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE entrega SET
        ide_pedi = p_ide_pedi,
        ide_prov = p_ide_prov,
        fecha_entr = p_fecha_entr,
        cantidad_total_entr = p_cantidad_total_entr,
        total_entr = p_total_entr,
        estado_entr = p_estado_entr,
        observacion_entr = p_observacion_entr,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_entr = p_ide_entr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Entrega actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_entrega(p_ide_entr integer, p_ide_pedi integer, p_ide_prov integer, p_fecha_entr timestamp without time zone, p_cantidad_total_entr integer, p_total_entr numeric, p_estado_entr character varying, p_observacion_entr character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 377 (class 1255 OID 18570)
-- Name: fn_actualizar_lote(integer, integer, date, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_lote(p_ide_lote integer, p_ide_prod integer, p_fecha_caducidad_lote date, p_stock_lote integer, p_estado_lote character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE lote SET
        ide_prod = p_ide_prod,
        fecha_caducidad_lote = p_fecha_caducidad_lote,
        stock_lote = p_stock_lote,
        estado_lote = p_estado_lote
    WHERE ide_lote = p_ide_lote;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Lote actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_lote(p_ide_lote integer, p_ide_prod integer, p_fecha_caducidad_lote date, p_stock_lote integer, p_estado_lote character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 367 (class 1255 OID 18571)
-- Name: fn_actualizar_marca(integer, character varying, character varying, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_marca(p_ide_marc integer, p_nombre_marc character varying, p_pais_origen_marc character varying, p_calidad_marc integer, p_descripcion_marc character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE marca SET
        nombre_marc = p_nombre_marc,
        pais_origen_marc = p_pais_origen_marc,
        calidad_marc = p_calidad_marc,
        descripcion_marc = p_descripcion_marc,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_marc = p_ide_marc;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Marca actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_marca(p_ide_marc integer, p_nombre_marc character varying, p_pais_origen_marc character varying, p_calidad_marc integer, p_descripcion_marc character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 18572)
-- Name: fn_actualizar_opciones(integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_opciones(p_ide_opci integer, p_nombre_opci character varying, p_ruta_opci character varying, p_activo_opci character varying, p_descripcion_opci character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE opciones SET
        nombre_opci = p_nombre_opci,
        ruta_opci = p_ruta_opci,
        activo_opci = p_activo_opci,
        descripcion_opci = p_descripcion_opci,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_opci = p_ide_opci;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Opción actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_opciones(p_ide_opci integer, p_nombre_opci character varying, p_ruta_opci character varying, p_activo_opci character varying, p_descripcion_opci character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 368 (class 1255 OID 18573)
-- Name: fn_actualizar_pedido(integer, integer, timestamp without time zone, timestamp without time zone, integer, numeric, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_pedido(p_ide_pedi integer, p_ide_empr integer, p_fecha_pedi timestamp without time zone, p_fecha_entr_pedi timestamp without time zone, p_cantidad_total_pedi integer, p_total_pedi numeric, p_estado_pedi character varying, p_motivo_pedi character varying, p_observacion_pedi character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE pedido SET
        ide_empr = p_ide_empr,
        fecha_pedi = p_fecha_pedi,
        fecha_entr_pedi = p_fecha_entr_pedi,
        cantidad_total_pedi = p_cantidad_total_pedi,
        total_pedi = p_total_pedi,
        estado_pedi = p_estado_pedi,
        motivo_pedi = p_motivo_pedi,
        observacion_pedi = p_observacion_pedi,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_pedi = p_ide_pedi;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Pedido actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_pedido(p_ide_pedi integer, p_ide_empr integer, p_fecha_pedi timestamp without time zone, p_fecha_entr_pedi timestamp without time zone, p_cantidad_total_pedi integer, p_total_pedi numeric, p_estado_pedi character varying, p_motivo_pedi character varying, p_observacion_pedi character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 18574)
-- Name: fn_actualizar_perfil(integer, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_perfil(p_ide_perf integer, p_ide_rol integer, p_nombre_perf character varying, p_descripcion_perf character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE perfil SET
        ide_rol = p_ide_rol,
        nombre_perf = p_nombre_perf,
        descripcion_perf = p_descripcion_perf,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_perf = p_ide_perf;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Perfil actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_perfil(p_ide_perf integer, p_ide_rol integer, p_nombre_perf character varying, p_descripcion_perf character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 392 (class 1255 OID 18575)
-- Name: fn_actualizar_perfil_opciones(integer, integer, integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_perfil_opciones(p_ide_perf_opci integer, p_ide_perf integer, p_ide_opci integer, p_listar character varying, p_insertar character varying, p_modificar character varying, p_eliminar character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE perfil_opciones SET
        ide_perf = p_ide_perf,
        ide_opci = p_ide_opci,
        listar = p_listar,
        insertar = p_insertar,
        modificar = p_modificar,
        eliminar = p_eliminar,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_perf_opci = p_ide_perf_opci;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Permiso de perfil actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_perfil_opciones(p_ide_perf_opci integer, p_ide_perf integer, p_ide_opci integer, p_listar character varying, p_insertar character varying, p_modificar character varying, p_eliminar character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 18576)
-- Name: fn_actualizar_producto(integer, integer, integer, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_producto(p_ide_prod integer, p_ide_cate integer, p_ide_marc integer, p_codigo_barra_prod character varying, p_nombre_prod character varying, p_precio_compra_prod numeric, p_precio_venta_prod numeric, p_iva_prod numeric, p_dcto_promo_prod numeric, p_dcto_caduc_prod numeric, p_precio_final_prod numeric, p_stock_prod integer, p_disponible_prod character varying, p_estado_prod character varying, p_descripcion_prod character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE producto SET
        ide_cate = p_ide_cate,
        ide_marc = p_ide_marc,
        codigo_barra_prod = p_codigo_barra_prod,
        nombre_prod = p_nombre_prod,
        precio_compra_prod = p_precio_compra_prod,
        precio_venta_prod = p_precio_venta_prod,
        iva_prod = p_iva_prod,
        dcto_promo_prod = p_dcto_promo_prod,
        dcto_caduc_prod = p_dcto_caduc_prod,
        precio_final_prod = p_precio_final_prod,
        stock_prod = p_stock_prod,
        disponible_prod = p_disponible_prod,
        estado_prod = p_estado_prod,
        descripcion_prod = p_descripcion_prod,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_prod = p_ide_prod;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Producto actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_producto(p_ide_prod integer, p_ide_cate integer, p_ide_marc integer, p_codigo_barra_prod character varying, p_nombre_prod character varying, p_precio_compra_prod numeric, p_precio_venta_prod numeric, p_iva_prod numeric, p_dcto_promo_prod numeric, p_dcto_caduc_prod numeric, p_precio_final_prod numeric, p_stock_prod integer, p_disponible_prod character varying, p_estado_prod character varying, p_descripcion_prod character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 18577)
-- Name: fn_actualizar_proveedor(integer, integer, character varying, date, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_proveedor(p_ide_prov integer, p_ide_empr integer, p_cedula_prov character varying, p_fecha_nacimiento_prov date, p_edad_prov integer, p_telefono_prov character varying, p_email_prov character varying, p_primer_nombre_prov character varying, p_apellido_paterno_prov character varying, p_segundo_nombre_prov character varying DEFAULT NULL::character varying, p_apellido_materno_prov character varying DEFAULT NULL::character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE proveedor SET
        ide_empr = p_ide_empr,
        cedula_prov = p_cedula_prov,
        fecha_nacimiento_prov = p_fecha_nacimiento_prov,
        edad_prov = p_edad_prov,
        telefono_prov = p_telefono_prov,
        email_prov = p_email_prov,
        primer_nombre_prov = p_primer_nombre_prov,
        apellido_paterno_prov = p_apellido_paterno_prov,
        segundo_nombre_prov = p_segundo_nombre_prov,
        apellido_materno_prov = p_apellido_materno_prov,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_prov = p_ide_prov;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Proveedor actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_proveedor(p_ide_prov integer, p_ide_empr integer, p_cedula_prov character varying, p_fecha_nacimiento_prov date, p_edad_prov integer, p_telefono_prov character varying, p_email_prov character varying, p_primer_nombre_prov character varying, p_apellido_paterno_prov character varying, p_segundo_nombre_prov character varying, p_apellido_materno_prov character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 18578)
-- Name: fn_actualizar_rol(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_rol(p_ide_rol integer, p_nombre_rol character varying, p_descripcion_rol character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE rol SET
        nombre_rol = p_nombre_rol,
        descripcion_rol = p_descripcion_rol,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_rol = p_ide_rol;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Rol actualizado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_rol(p_ide_rol integer, p_nombre_rol character varying, p_descripcion_rol character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 362 (class 1255 OID 18579)
-- Name: fn_actualizar_venta(integer, integer, integer, character varying, timestamp without time zone, integer, numeric, numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_actualizar_venta(p_ide_vent integer, p_ide_empl integer, p_ide_clie integer, p_num_factura_vent character varying, p_fecha_vent timestamp without time zone, p_cantidad_vent integer, p_sub_total_vent numeric, p_total_vent numeric, p_dcto_vent numeric, p_estado_vent character varying, p_usua_actua character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE venta SET
        ide_empl = p_ide_empl,
        ide_clie = p_ide_clie,
        num_factura_vent = p_num_factura_vent,
        fecha_vent = p_fecha_vent,
        cantidad_vent = p_cantidad_vent,
        sub_total_vent = p_sub_total_vent,
        dcto_vent = p_dcto_vent,
        total_vent = p_total_vent,
        estado_vent = p_estado_vent,
        usua_actua = p_usua_actua,
        fecha_actua = CURRENT_TIMESTAMP
    WHERE ide_vent = p_ide_vent;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Venta actualizada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_actualizar_venta(p_ide_vent integer, p_ide_empl integer, p_ide_clie integer, p_num_factura_vent character varying, p_fecha_vent timestamp without time zone, p_cantidad_vent integer, p_sub_total_vent numeric, p_total_vent numeric, p_dcto_vent numeric, p_estado_vent character varying, p_usua_actua character varying, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 18580)
-- Name: fn_buscar_acceso_usuario(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_acceso_usuario(p_ide_acce integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM acceso_usuario WHERE ide_acce = p_ide_acce;
    p_response := '{"success": true, "message": "Acceso de usuario encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_acceso_usuario(p_ide_acce integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 350 (class 1255 OID 18581)
-- Name: fn_buscar_categoria(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_categoria(p_ide_cate integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM categoria WHERE ide_cate = p_ide_cate;
    p_response := '{"success": true, "message": "Categoría encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_categoria(p_ide_cate integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 376 (class 1255 OID 18582)
-- Name: fn_buscar_cliente(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_cliente(p_ide_clie integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM cliente WHERE ide_clie = p_ide_clie;
    p_response := '{"success": true, "message": "Cliente encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_cliente(p_ide_clie integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 335 (class 1255 OID 18583)
-- Name: fn_buscar_cuenta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_cuenta(p_ide_cuen integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM cuenta WHERE ide_cuen = p_ide_cuen;
    p_response := '{"success": true, "message": "Cuenta encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_cuenta(p_ide_cuen integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 18584)
-- Name: fn_buscar_detalle_entrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_detalle_entrega(p_ide_deta_entr integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_entrega WHERE ide_deta_entr = p_ide_deta_entr;
    p_response := '{"success": true, "message": "Detalle de entrega encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_detalle_entrega(p_ide_deta_entr integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 373 (class 1255 OID 18585)
-- Name: fn_buscar_detalle_pedido(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_detalle_pedido(p_ide_deta_pedi integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_pedido WHERE ide_deta_pedi = p_ide_deta_pedi;
    p_response := '{"success": true, "message": "Detalle de pedido encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_detalle_pedido(p_ide_deta_pedi integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 18586)
-- Name: fn_buscar_detalle_venta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_detalle_venta(p_ide_deta_vent integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_venta WHERE ide_deta_vent = p_ide_deta_vent;
    p_response := '{"success": true, "message": "Detalle de venta encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_detalle_venta(p_ide_deta_vent integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 18587)
-- Name: fn_buscar_empleado(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_empleado(p_ide_empl integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM empleado WHERE ide_empl = p_ide_empl;
    p_response := '{"success": true, "message": "Empleado encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_empleado(p_ide_empl integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 389 (class 1255 OID 18588)
-- Name: fn_buscar_empresa(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_empresa(p_ide_empr integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM empresa WHERE ide_empr = p_ide_empr;
    p_response := '{"success": true, "message": "Empresa encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_empresa(p_ide_empr integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 18589)
-- Name: fn_buscar_empresa_precios(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_empresa_precios(p_ide_empr_prod integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM empresa_precios WHERE ide_empr_prod = p_ide_empr_prod;
    p_response := '{"success": true, "message": "Precio de empresa encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_empresa_precios(p_ide_empr_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 18590)
-- Name: fn_buscar_entrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_entrega(p_ide_entr integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM entrega WHERE ide_entr = p_ide_entr;
    p_response := '{"success": true, "message": "Entrega encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_entrega(p_ide_entr integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 18591)
-- Name: fn_buscar_lote(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_lote(p_ide_lote integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM lote WHERE ide_lote = p_ide_lote;
    p_response := '{"success": true, "message": "Lote encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_lote(p_ide_lote integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 358 (class 1255 OID 18592)
-- Name: fn_buscar_marca(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_marca(p_ide_marc integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM marca WHERE ide_marc = p_ide_marc;
    p_response := '{"success": true, "message": "Marca encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_marca(p_ide_marc integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 18593)
-- Name: fn_buscar_opciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_opciones(p_ide_opci integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM opciones WHERE ide_opci = p_ide_opci;
    p_response := '{"success": true, "message": "Opción encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_opciones(p_ide_opci integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 18594)
-- Name: fn_buscar_pedido(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_pedido(p_ide_pedi integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM pedido WHERE ide_pedi = p_ide_pedi;
    p_response := '{"success": true, "message": "Pedido encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_pedido(p_ide_pedi integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 313 (class 1255 OID 18595)
-- Name: fn_buscar_perfil(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_perfil(p_ide_perf integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM perfil WHERE ide_perf = p_ide_perf;
    p_response := '{"success": true, "message": "Perfil encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_perfil(p_ide_perf integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 393 (class 1255 OID 18596)
-- Name: fn_buscar_perfil_opciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_perfil_opciones(p_ide_perf_opci integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM perfil_opciones WHERE ide_perf_opci = p_ide_perf_opci;
    p_response := '{"success": true, "message": "Permiso de perfil encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_perfil_opciones(p_ide_perf_opci integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 352 (class 1255 OID 18597)
-- Name: fn_buscar_producto(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_producto(p_ide_prod integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM producto WHERE ide_prod = p_ide_prod;
    p_response := '{"success": true, "message": "Producto encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_producto(p_ide_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 348 (class 1255 OID 18598)
-- Name: fn_buscar_proveedor(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_proveedor(p_ide_prov integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM proveedor WHERE ide_prov = p_ide_prov;
    p_response := '{"success": true, "message": "Proveedor encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_proveedor(p_ide_prov integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 18599)
-- Name: fn_buscar_rol(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_rol(p_ide_rol integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM rol WHERE ide_rol = p_ide_rol;
    p_response := '{"success": true, "message": "Rol encontrado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_rol(p_ide_rol integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 310 (class 1255 OID 18600)
-- Name: fn_buscar_venta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_buscar_venta(p_ide_vent integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM venta WHERE ide_vent = p_ide_vent;
    p_response := '{"success": true, "message": "Venta encontrada"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_buscar_venta(p_ide_vent integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 322 (class 1255 OID 18601)
-- Name: fn_eliminar_acceso_usuario(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_acceso_usuario(p_ide_acce integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM acceso_usuario WHERE ide_acce = p_ide_acce;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Acceso de usuario eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_acceso_usuario(p_ide_acce integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 323 (class 1255 OID 18602)
-- Name: fn_eliminar_categoria(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_categoria(p_ide_cate integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM categoria WHERE ide_cate = p_ide_cate;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Categoría eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_categoria(p_ide_cate integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 18603)
-- Name: fn_eliminar_cliente(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_cliente(p_ide_clie integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM cliente WHERE ide_clie = p_ide_clie;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cliente eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_cliente(p_ide_clie integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 332 (class 1255 OID 18604)
-- Name: fn_eliminar_cuenta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_cuenta(p_ide_cuen integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM cuenta WHERE ide_cuen = p_ide_cuen;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cuenta eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_cuenta(p_ide_cuen integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 359 (class 1255 OID 18605)
-- Name: fn_eliminar_detalle_entrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_detalle_entrega(p_ide_deta_entr integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM detalle_entrega WHERE ide_deta_entr = p_ide_deta_entr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de entrega eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_detalle_entrega(p_ide_deta_entr integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 388 (class 1255 OID 18606)
-- Name: fn_eliminar_detalle_pedido(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_detalle_pedido(p_ide_deta_pedi integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM detalle_pedido WHERE ide_deta_pedi = p_ide_deta_pedi;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de pedido eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_detalle_pedido(p_ide_deta_pedi integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 369 (class 1255 OID 18607)
-- Name: fn_eliminar_detalle_venta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_detalle_venta(p_ide_deta_vent integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM detalle_venta WHERE ide_deta_vent = p_ide_deta_vent;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de venta eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_detalle_venta(p_ide_deta_vent integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 343 (class 1255 OID 18608)
-- Name: fn_eliminar_empleado(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_empleado(p_ide_empl integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM empleado WHERE ide_empl = p_ide_empl;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empleado eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_empleado(p_ide_empl integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 316 (class 1255 OID 18609)
-- Name: fn_eliminar_empresa(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_empresa(p_ide_empr integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM empresa WHERE ide_empr = p_ide_empr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empresa eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_empresa(p_ide_empr integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 379 (class 1255 OID 18610)
-- Name: fn_eliminar_empresa_precios(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_empresa_precios(p_ide_empr_prod integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM empresa_precios WHERE ide_empr_prod = p_ide_empr_prod;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Precio de empresa eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_empresa_precios(p_ide_empr_prod integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 18611)
-- Name: fn_eliminar_entrega(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_entrega(p_ide_entr integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM entrega WHERE ide_entr = p_ide_entr;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Entrega eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_entrega(p_ide_entr integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 396 (class 1255 OID 18612)
-- Name: fn_eliminar_lote(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_lote(p_ide_lote integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM lote WHERE ide_lote = p_ide_lote;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Lote eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_lote(p_ide_lote integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 346 (class 1255 OID 18613)
-- Name: fn_eliminar_marca(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_marca(p_ide_marc integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM marca WHERE ide_marc = p_ide_marc;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Marca eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_marca(p_ide_marc integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 398 (class 1255 OID 18614)
-- Name: fn_eliminar_opciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_opciones(p_ide_opci integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM opciones WHERE ide_opci = p_ide_opci;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Opción eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_opciones(p_ide_opci integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 18615)
-- Name: fn_eliminar_pedido(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_pedido(p_ide_pedi integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM pedido WHERE ide_pedi = p_ide_pedi;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Pedido eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_pedido(p_ide_pedi integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 383 (class 1255 OID 18616)
-- Name: fn_eliminar_perfil(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_perfil(p_ide_perf integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM perfil WHERE ide_perf = p_ide_perf;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Perfil eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_perfil(p_ide_perf integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 378 (class 1255 OID 18617)
-- Name: fn_eliminar_perfil_opciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_perfil_opciones(p_ide_perf_opci integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM perfil_opciones WHERE ide_perf_opci = p_ide_perf_opci;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Permiso de perfil eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_perfil_opciones(p_ide_perf_opci integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 331 (class 1255 OID 18618)
-- Name: fn_eliminar_producto(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_producto(p_ide_prod integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM producto WHERE ide_prod = p_ide_prod;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Producto eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_producto(p_ide_prod integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 18619)
-- Name: fn_eliminar_proveedor(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_proveedor(p_ide_prov integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM proveedor WHERE ide_prov = p_ide_prov;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Proveedor eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_proveedor(p_ide_prov integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 295 (class 1255 OID 18620)
-- Name: fn_eliminar_rol(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_rol(p_ide_rol integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM rol WHERE ide_rol = p_ide_rol;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Rol eliminado correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_rol(p_ide_rol integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 317 (class 1255 OID 18621)
-- Name: fn_eliminar_venta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_eliminar_venta(p_ide_vent integer, OUT p_result integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM venta WHERE ide_vent = p_ide_vent;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Venta eliminada correctamente"}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_eliminar_venta(p_ide_vent integer, OUT p_result integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 308 (class 1255 OID 18622)
-- Name: fn_filtrar_acceso_usuario(integer, character varying, character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_acceso_usuario(p_ide_cuen integer DEFAULT NULL::integer, p_ip_acce character varying DEFAULT NULL::character varying, p_navegador_acce character varying DEFAULT NULL::character varying, p_fecha_desde timestamp without time zone DEFAULT NULL::timestamp without time zone, p_fecha_hasta timestamp without time zone DEFAULT NULL::timestamp without time zone, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM acceso_usuario
    WHERE (p_ide_cuen IS NULL OR ide_cuen = p_ide_cuen)
    AND (p_ip_acce IS NULL OR ip_acce = p_ip_acce)
    AND (p_navegador_acce IS NULL OR navegador_acce ILIKE '%' || p_navegador_acce || '%')
    AND (p_fecha_desde IS NULL OR fecha_acce >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR fecha_acce <= p_fecha_hasta)
    ORDER BY fecha_acce DESC;
    
    p_response := '{"success": true, "message": "Filtrado de accesos de usuario completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_acceso_usuario(p_ide_cuen integer, p_ip_acce character varying, p_navegador_acce character varying, p_fecha_desde timestamp without time zone, p_fecha_hasta timestamp without time zone, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 18623)
-- Name: fn_filtrar_categoria(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_categoria(p_nombre_cate character varying DEFAULT NULL::character varying, p_descripcion_cate character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM categoria
    WHERE (p_nombre_cate IS NULL OR nombre_cate ILIKE '%' || p_nombre_cate || '%')
    AND (p_descripcion_cate IS NULL OR descripcion_cate ILIKE '%' || p_descripcion_cate || '%')
    ORDER BY nombre_cate;
    
    p_response := '{"success": true, "message": "Filtrado de categorías completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_categoria(p_nombre_cate character varying, p_descripcion_cate character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 337 (class 1255 OID 18624)
-- Name: fn_filtrar_cliente(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_cliente(p_cedula_clie character varying DEFAULT NULL::character varying, p_primer_nombre_clie character varying DEFAULT NULL::character varying, p_apellido_paterno_clie character varying DEFAULT NULL::character varying, p_es_socio character varying DEFAULT NULL::character varying, p_es_tercera_edad character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM cliente
    WHERE (p_cedula_clie IS NULL OR cedula_clie = p_cedula_clie)
    AND (p_primer_nombre_clie IS NULL OR primer_nombre_clie ILIKE '%' || p_primer_nombre_clie || '%')
    AND (p_apellido_paterno_clie IS NULL OR apellido_paterno_clie ILIKE '%' || p_apellido_paterno_clie || '%')
    AND (p_es_socio IS NULL OR es_socio = p_es_socio)
    AND (p_es_tercera_edad IS NULL OR es_tercera_edad = p_es_tercera_edad)
    ORDER BY apellido_paterno_clie, primer_nombre_clie;
    
    p_response := '{"success": true, "message": "Filtrado de clientes completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_cliente(p_cedula_clie character varying, p_primer_nombre_clie character varying, p_apellido_paterno_clie character varying, p_es_socio character varying, p_es_tercera_edad character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 326 (class 1255 OID 18625)
-- Name: fn_filtrar_cuenta(integer, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_cuenta(p_ide_empl integer DEFAULT NULL::integer, p_ide_perf integer DEFAULT NULL::integer, p_usuario_cuen character varying DEFAULT NULL::character varying, p_estado_cuen character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM cuenta
    WHERE (p_ide_empl IS NULL OR ide_empl = p_ide_empl)
    AND (p_ide_perf IS NULL OR ide_perf = p_ide_perf)
    AND (p_usuario_cuen IS NULL OR usuario_cuen ILIKE '%' || p_usuario_cuen || '%')
    AND (p_estado_cuen IS NULL OR estado_cuen = p_estado_cuen)
    ORDER BY usuario_cuen;
    
    p_response := '{"success": true, "message": "Filtrado de cuentas completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_cuenta(p_ide_empl integer, p_ide_perf integer, p_usuario_cuen character varying, p_estado_cuen character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 363 (class 1255 OID 18626)
-- Name: fn_filtrar_detalle_entrega(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_detalle_entrega(p_ide_entr integer DEFAULT NULL::integer, p_ide_prod integer DEFAULT NULL::integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM detalle_entrega
    WHERE (p_ide_entr IS NULL OR ide_entr = p_ide_entr)
    AND (p_ide_prod IS NULL OR ide_prod = p_ide_prod)
    ORDER BY ide_deta_entr;
    
    p_response := '{"success": true, "message": "Filtrado de detalles de entrega completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_detalle_entrega(p_ide_entr integer, p_ide_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 390 (class 1255 OID 18627)
-- Name: fn_filtrar_detalle_pedido(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_detalle_pedido(p_ide_pedi integer DEFAULT NULL::integer, p_ide_prod integer DEFAULT NULL::integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM detalle_pedido
    WHERE (p_ide_pedi IS NULL OR ide_pedi = p_ide_pedi)
    AND (p_ide_prod IS NULL OR ide_prod = p_ide_prod)
    ORDER BY ide_deta_pedi;
    
    p_response := '{"success": true, "message": "Filtrado de detalles de pedido completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_detalle_pedido(p_ide_pedi integer, p_ide_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 321 (class 1255 OID 18628)
-- Name: fn_filtrar_detalle_venta(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_detalle_venta(p_ide_vent integer DEFAULT NULL::integer, p_ide_prod integer DEFAULT NULL::integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM detalle_venta
    WHERE (p_ide_vent IS NULL OR ide_vent = p_ide_vent)
    AND (p_ide_prod IS NULL OR ide_prod = p_ide_prod)
    ORDER BY ide_deta_vent;
    
    p_response := '{"success": true, "message": "Filtrado de detalles de venta completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_detalle_venta(p_ide_vent integer, p_ide_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 339 (class 1255 OID 18629)
-- Name: fn_filtrar_empleado(integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_empleado(p_ide_rol integer DEFAULT NULL::integer, p_cedula_empl character varying DEFAULT NULL::character varying, p_primer_nombre_empl character varying DEFAULT NULL::character varying, p_apellido_paterno_empl character varying DEFAULT NULL::character varying, p_titulo_empl character varying DEFAULT NULL::character varying, p_estado_empl character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM empleado
    WHERE (p_ide_rol IS NULL OR ide_rol = p_ide_rol)
    AND (p_cedula_empl IS NULL OR cedula_empl = p_cedula_empl)
    AND (p_primer_nombre_empl IS NULL OR primer_nombre_empl ILIKE '%' || p_primer_nombre_empl || '%')
    AND (p_apellido_paterno_empl IS NULL OR apellido_paterno_empl ILIKE '%' || p_apellido_paterno_empl || '%')
    AND (p_titulo_empl IS NULL OR titulo_empl ILIKE '%' || p_titulo_empl || '%')
    AND (p_estado_empl IS NULL OR estado_empl = p_estado_empl)
    ORDER BY apellido_paterno_empl, primer_nombre_empl;
    
    p_response := '{"success": true, "message": "Filtrado de empleados completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_empleado(p_ide_rol integer, p_cedula_empl character varying, p_primer_nombre_empl character varying, p_apellido_paterno_empl character varying, p_titulo_empl character varying, p_estado_empl character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 330 (class 1255 OID 18630)
-- Name: fn_filtrar_empresa(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_empresa(p_nombre_empr character varying DEFAULT NULL::character varying, p_estado_empr character varying DEFAULT NULL::character varying, p_responsable_empr character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM empresa
    WHERE (p_nombre_empr IS NULL OR nombre_empr ILIKE '%' || p_nombre_empr || '%')
    AND (p_estado_empr IS NULL OR estado_empr = p_estado_empr)
    AND (p_responsable_empr IS NULL OR responsable_empr ILIKE '%' || p_responsable_empr || '%')
    ORDER BY nombre_empr;
    
    p_response := '{"success": true, "message": "Filtrado de empresas completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_empresa(p_nombre_empr character varying, p_estado_empr character varying, p_responsable_empr character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 18631)
-- Name: fn_filtrar_empresa_precios(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_empresa_precios(p_ide_empr integer DEFAULT NULL::integer, p_ide_prod integer DEFAULT NULL::integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM empresa_precios
    WHERE (p_ide_empr IS NULL OR ide_empr = p_ide_empr)
    AND (p_ide_prod IS NULL OR ide_prod = p_ide_prod)
    ORDER BY ide_empr, ide_prod;
    
    p_response := '{"success": true, "message": "Filtrado de precios de empresa completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_empresa_precios(p_ide_empr integer, p_ide_prod integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 18632)
-- Name: fn_filtrar_entrega(integer, integer, character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_entrega(p_ide_pedi integer DEFAULT NULL::integer, p_ide_prov integer DEFAULT NULL::integer, p_estado_entr character varying DEFAULT NULL::character varying, p_fecha_desde timestamp without time zone DEFAULT NULL::timestamp without time zone, p_fecha_hasta timestamp without time zone DEFAULT NULL::timestamp without time zone, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM entrega
    WHERE (p_ide_pedi IS NULL OR ide_pedi = p_ide_pedi)
    AND (p_ide_prov IS NULL OR ide_prov = p_ide_prov)
    AND (p_estado_entr IS NULL OR estado_entr = p_estado_entr)
    AND (p_fecha_desde IS NULL OR fecha_entr >= p_fecha_desde)
	AND (p_fecha_hasta IS NULL OR fecha_entr <= p_fecha_hasta)
    ORDER BY fecha_entr DESC;

    p_response := '{"success": true, "message": "Filtrado de entregas completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_entrega(p_ide_pedi integer, p_ide_prov integer, p_estado_entr character varying, p_fecha_desde timestamp without time zone, p_fecha_hasta timestamp without time zone, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 342 (class 1255 OID 18633)
-- Name: fn_filtrar_lote(integer, character varying, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_lote(p_ide_prod integer DEFAULT NULL::integer, p_estado_lote character varying DEFAULT NULL::character varying, p_fecha_caducidad_desde date DEFAULT NULL::date, p_fecha_caducidad_hasta date DEFAULT NULL::date, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM lote
    WHERE (p_ide_prod IS NULL OR ide_prod = p_ide_prod)
    AND (p_estado_lote IS NULL OR estado_lote = p_estado_lote)
    AND (p_fecha_caducidad_desde IS NULL OR fecha_caducidad_lote >= p_fecha_caducidad_desde)
    AND (p_fecha_caducidad_hasta IS NULL OR fecha_caducidad_lote <= p_fecha_caducidad_hasta)
    ORDER BY fecha_caducidad_lote;
    
    p_response := '{"success": true, "message": "Filtrado de lotes completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_lote(p_ide_prod integer, p_estado_lote character varying, p_fecha_caducidad_desde date, p_fecha_caducidad_hasta date, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 366 (class 1255 OID 18634)
-- Name: fn_filtrar_marca(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_marca(p_nombre_marc character varying DEFAULT NULL::character varying, p_pais_origen_marc character varying DEFAULT NULL::character varying, p_calidad_marc integer DEFAULT NULL::integer, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM marca
    WHERE (p_nombre_marc IS NULL OR nombre_marc ILIKE '%' || p_nombre_marc || '%')
    AND (p_pais_origen_marc IS NULL OR pais_origen_marc ILIKE '%' || p_pais_origen_marc || '%')
    AND (p_calidad_marc IS NULL OR calidad_marc = p_calidad_marc)
    ORDER BY nombre_marc;
    
    p_response := '{"success": true, "message": "Filtrado de marcas completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_marca(p_nombre_marc character varying, p_pais_origen_marc character varying, p_calidad_marc integer, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 364 (class 1255 OID 18635)
-- Name: fn_filtrar_opciones(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_opciones(p_nombre_opci character varying DEFAULT NULL::character varying, p_ruta_opci character varying DEFAULT NULL::character varying, p_activo_opci character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM opciones
    WHERE (p_nombre_opci IS NULL OR nombre_opci ILIKE '%' || p_nombre_opci || '%')
    AND (p_ruta_opci IS NULL OR ruta_opci ILIKE '%' || p_ruta_opci || '%')
    AND (p_activo_opci IS NULL OR activo_opci = p_activo_opci)
    ORDER BY nombre_opci;
    
    p_response := '{"success": true, "message": "Filtrado de opciones completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_opciones(p_nombre_opci character varying, p_ruta_opci character varying, p_activo_opci character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 320 (class 1255 OID 18636)
-- Name: fn_filtrar_pedido(integer, character varying, character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_pedido(p_ide_empr integer DEFAULT NULL::integer, p_estado_pedi character varying DEFAULT NULL::character varying, p_motivo_pedi character varying DEFAULT NULL::character varying, p_fecha_pedi timestamp without time zone DEFAULT NULL::timestamp without time zone, p_fecha_entr_pedi timestamp without time zone DEFAULT NULL::timestamp without time zone, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM pedido
    WHERE (p_ide_empr IS NULL OR ide_empr = p_ide_empr)
    AND (p_estado_pedi IS NULL OR estado_pedi = p_estado_pedi)
    AND (p_motivo_pedi IS NULL OR motivo_pedi = p_motivo_pedi)
    AND (p_fecha_pedi IS NULL OR fecha_pedi >= p_fecha_pedi)
    AND (p_fecha_entr_pedi IS NULL OR fecha_entr_pedi <= p_fecha_entr_pedi)
    ORDER BY fecha_pedi DESC;
    
    p_response := '{"success": true, "message": "Filtrado de pedidos completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_pedido(p_ide_empr integer, p_estado_pedi character varying, p_motivo_pedi character varying, p_fecha_pedi timestamp without time zone, p_fecha_entr_pedi timestamp without time zone, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 328 (class 1255 OID 18637)
-- Name: fn_filtrar_perfil(integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_perfil(p_ide_rol integer DEFAULT NULL::integer, p_nombre_perf character varying DEFAULT NULL::character varying, p_descripcion_perf character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM perfil
    WHERE (p_ide_rol IS NULL OR ide_rol = p_ide_rol)
    AND (p_nombre_perf IS NULL OR nombre_perf ILIKE '%' || p_nombre_perf || '%')
    AND (p_descripcion_perf IS NULL OR descripcion_perf ILIKE '%' || p_descripcion_perf || '%')
    ORDER BY nombre_perf;
    
    p_response := '{"success": true, "message": "Filtrado de perfiles completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_perfil(p_ide_rol integer, p_nombre_perf character varying, p_descripcion_perf character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 18638)
-- Name: fn_filtrar_perfil_opciones(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_perfil_opciones(p_ide_perf integer DEFAULT NULL::integer, p_ide_opci integer DEFAULT NULL::integer, p_listar character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM perfil_opciones
    WHERE (p_ide_perf IS NULL OR ide_perf = p_ide_perf)
    AND (p_ide_opci IS NULL OR ide_opci = p_ide_opci)
    AND (p_listar IS NULL OR listar = p_listar)
    ORDER BY ide_perf, ide_opci;
    
    p_response := '{"success": true, "message": "Filtrado de permisos de perfil completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_perfil_opciones(p_ide_perf integer, p_ide_opci integer, p_listar character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 356 (class 1255 OID 18639)
-- Name: fn_filtrar_producto(integer, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_producto(p_ide_cate integer DEFAULT NULL::integer, p_ide_marc integer DEFAULT NULL::integer, p_nombre_prod character varying DEFAULT NULL::character varying, p_codigo_barra_prod character varying DEFAULT NULL::character varying, p_estado_prod character varying DEFAULT NULL::character varying, p_disponible_prod character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM producto
    WHERE (p_ide_cate IS NULL OR ide_cate = p_ide_cate)
    AND (p_ide_marc IS NULL OR ide_marc = p_ide_marc)
    AND (p_nombre_prod IS NULL OR nombre_prod ILIKE '%' || p_nombre_prod || '%')
    AND (p_codigo_barra_prod IS NULL OR codigo_barra_prod = p_codigo_barra_prod)
    AND (p_estado_prod IS NULL OR estado_prod = p_estado_prod)
    AND (p_disponible_prod IS NULL OR disponible_prod = p_disponible_prod)
    ORDER BY nombre_prod;
    
    p_response := '{"success": true, "message": "Filtrado de productos completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_producto(p_ide_cate integer, p_ide_marc integer, p_nombre_prod character varying, p_codigo_barra_prod character varying, p_estado_prod character varying, p_disponible_prod character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 387 (class 1255 OID 18640)
-- Name: fn_filtrar_proveedor(integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_proveedor(p_ide_empr integer DEFAULT NULL::integer, p_cedula_prov character varying DEFAULT NULL::character varying, p_primer_nombre_prov character varying DEFAULT NULL::character varying, p_apellido_paterno_prov character varying DEFAULT NULL::character varying, p_email_prov character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM proveedor
    WHERE (p_ide_empr IS NULL OR ide_empr = p_ide_empr)
    AND (p_cedula_prov IS NULL OR cedula_prov = p_cedula_prov)
    AND (p_primer_nombre_prov IS NULL OR primer_nombre_prov ILIKE '%' || p_primer_nombre_prov || '%')
    AND (p_apellido_paterno_prov IS NULL OR apellido_paterno_prov ILIKE '%' || p_apellido_paterno_prov || '%')
    AND (p_email_prov IS NULL OR email_prov ILIKE '%' || p_email_prov || '%')
    ORDER BY apellido_paterno_prov, primer_nombre_prov;
    
    p_response := '{"success": true, "message": "Filtrado de proveedores completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_proveedor(p_ide_empr integer, p_cedula_prov character varying, p_primer_nombre_prov character varying, p_apellido_paterno_prov character varying, p_email_prov character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 18641)
-- Name: fn_filtrar_rol(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_rol(p_nombre_rol character varying DEFAULT NULL::character varying, p_descripcion_rol character varying DEFAULT NULL::character varying, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM rol
    WHERE (p_nombre_rol IS NULL OR nombre_rol ILIKE '%' || p_nombre_rol || '%')
    AND (p_descripcion_rol IS NULL OR descripcion_rol ILIKE '%' || p_descripcion_rol || '%')
    ORDER BY nombre_rol;
    
    p_response := '{"success": true, "message": "Filtrado de roles completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_rol(p_nombre_rol character varying, p_descripcion_rol character varying, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 333 (class 1255 OID 18642)
-- Name: fn_filtrar_venta(integer, integer, character varying, character varying, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_filtrar_venta(p_ide_empl integer DEFAULT NULL::integer, p_ide_clie integer DEFAULT NULL::integer, p_num_factura_vent character varying DEFAULT NULL::character varying, p_estado_vent character varying DEFAULT NULL::character varying, p_fecha_desde timestamp without time zone DEFAULT NULL::timestamp without time zone, p_fecha_hasta timestamp without time zone DEFAULT NULL::timestamp without time zone, OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR
    SELECT * FROM venta
    WHERE (p_ide_empl IS NULL OR ide_empl = p_ide_empl)
    AND (p_ide_clie IS NULL OR ide_clie = p_ide_clie)
    AND (p_num_factura_vent IS NULL OR num_factura_vent ILIKE '%' || p_num_factura_vent || '%')
    AND (p_estado_vent IS NULL OR estado_vent = p_estado_vent)
    AND (p_fecha_desde IS NULL OR fecha_vent >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR fecha_vent <= p_fecha_hasta)
    ORDER BY fecha_vent DESC;
    
    p_response := '{"success": true, "message": "Filtrado de ventas completado"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_filtrar_venta(p_ide_empl integer, p_ide_clie integer, p_num_factura_vent character varying, p_estado_vent character varying, p_fecha_desde timestamp without time zone, p_fecha_hasta timestamp without time zone, OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 18643)
-- Name: fn_insertar_acceso_usuario(integer, character varying, timestamp without time zone, integer, character varying, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_acceso_usuario(p_ide_cuen integer, p_navegador_acce character varying, p_fecha_acce timestamp without time zone DEFAULT CURRENT_TIMESTAMP, p_num_int_fall_acce integer DEFAULT 0, p_ip_acce character varying DEFAULT '999.999.999.999'::character varying, p_latitud_acce numeric DEFAULT NULL::numeric, p_longitud_acce numeric DEFAULT NULL::numeric, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO acceso_usuario(
        ide_cuen, navegador_acce, fecha_acce, num_int_fall_acce, ip_acce,
        latitud_acce, longitud_acce
    ) VALUES (
        p_ide_cuen, p_navegador_acce, p_fecha_acce, p_num_int_fall_acce, p_ip_acce,
        p_latitud_acce, p_longitud_acce
    ) RETURNING ide_acce INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Acceso de usuario registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_acceso_usuario(p_ide_cuen integer, p_navegador_acce character varying, p_fecha_acce timestamp without time zone, p_num_int_fall_acce integer, p_ip_acce character varying, p_latitud_acce numeric, p_longitud_acce numeric, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 340 (class 1255 OID 18644)
-- Name: fn_insertar_categoria(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_categoria(p_nombre_cate character varying, p_descripcion_cate character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO categoria(
        nombre_cate, descripcion_cate, usua_ingre
    ) VALUES (
        p_nombre_cate, p_descripcion_cate, p_usua_ingre
    ) RETURNING ide_cate INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Categoría registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_categoria(p_nombre_cate character varying, p_descripcion_cate character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 18645)
-- Name: fn_insertar_cliente(character varying, date, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_cliente(p_cedula_clie character varying, p_fecha_nacimiento_clie date, p_edad_clie integer, p_telefono_clie character varying, p_primer_nombre_clie character varying, p_apellido_paterno_clie character varying, p_email_clie character varying DEFAULT 'Ninguno'::character varying, p_es_socio character varying DEFAULT 'no'::character varying, p_es_tercera_edad character varying DEFAULT 'no'::character varying, p_segundo_nombre_clie character varying DEFAULT NULL::character varying, p_apellido_materno_clie character varying DEFAULT NULL::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO cliente(
        cedula_clie, fecha_nacimiento_clie, edad_clie, telefono_clie,
        primer_nombre_clie, apellido_paterno_clie, email_clie, es_socio,
        es_tercera_edad, segundo_nombre_clie, apellido_materno_clie, usua_ingre
    ) VALUES (
        p_cedula_clie, p_fecha_nacimiento_clie, p_edad_clie, p_telefono_clie,
        p_primer_nombre_clie, p_apellido_paterno_clie, p_email_clie, p_es_socio,
        p_es_tercera_edad, p_segundo_nombre_clie, p_apellido_materno_clie, p_usua_ingre
    ) RETURNING ide_clie INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cliente registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_cliente(p_cedula_clie character varying, p_fecha_nacimiento_clie date, p_edad_clie integer, p_telefono_clie character varying, p_primer_nombre_clie character varying, p_apellido_paterno_clie character varying, p_email_clie character varying, p_es_socio character varying, p_es_tercera_edad character varying, p_segundo_nombre_clie character varying, p_apellido_materno_clie character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 18646)
-- Name: fn_insertar_cuenta(integer, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_cuenta(p_ide_empl integer, p_ide_perf integer, p_usuario_cuen character varying, p_password_cuen character varying, p_estado_cuen character varying DEFAULT 'inactivo'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO cuenta(
        ide_empl, ide_perf, usuario_cuen, password_cuen, estado_cuen, usua_ingre
    ) VALUES (
        p_ide_empl, p_ide_perf, p_usuario_cuen, p_password_cuen, p_estado_cuen, p_usua_ingre
    ) RETURNING ide_cuen INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Cuenta registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_cuenta(p_ide_empl integer, p_ide_perf integer, p_usuario_cuen character varying, p_password_cuen character varying, p_estado_cuen character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 365 (class 1255 OID 18647)
-- Name: fn_insertar_detalle_entrega(integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_detalle_entrega(p_ide_entr integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric DEFAULT 0, p_iva_prod numeric DEFAULT 0, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO detalle_entrega(
        ide_entr, ide_prod, cantidad_prod, precio_unitario_prod,
        dcto_prod, iva_prod, subtotal_prod
    ) VALUES (
        p_ide_entr, p_ide_prod, p_cantidad_prod, p_precio_unitario_prod,
        p_dcto_prod, p_iva_prod, p_subtotal_prod
    ) RETURNING ide_deta_entr INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de entrega registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_detalle_entrega(p_ide_entr integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 324 (class 1255 OID 18648)
-- Name: fn_insertar_detalle_pedido(integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_detalle_pedido(p_ide_pedi integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric DEFAULT 0, p_iva_prod numeric DEFAULT 0, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO detalle_pedido(
        ide_pedi, ide_prod, cantidad_prod, precio_unitario_prod,
        dcto_prod, iva_prod, subtotal_prod
    ) VALUES (
        p_ide_pedi, p_ide_prod, p_cantidad_prod, p_precio_unitario_prod,
        p_dcto_prod, p_iva_prod, p_subtotal_prod
    ) RETURNING ide_deta_pedi INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de pedido registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_detalle_pedido(p_ide_pedi integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_iva_prod numeric, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 18649)
-- Name: fn_insertar_detalle_venta(integer, integer, integer, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_detalle_venta(p_ide_vent integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric DEFAULT 0, p_dcto_promo numeric DEFAULT 0, p_iva_prod numeric DEFAULT 0, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO detalle_venta(
        ide_vent, ide_prod, cantidad_prod, precio_unitario_prod,
        dcto_prod, dcto_promo, iva_prod, subtotal_prod
    ) VALUES (
        p_ide_vent, p_ide_prod, p_cantidad_prod, p_precio_unitario_prod,
        p_dcto_prod, p_dcto_promo, p_iva_prod, p_subtotal_prod
    ) RETURNING ide_deta_vent INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Detalle de venta registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_detalle_venta(p_ide_vent integer, p_ide_prod integer, p_cantidad_prod integer, p_precio_unitario_prod numeric, p_subtotal_prod numeric, p_dcto_prod numeric, p_dcto_promo numeric, p_iva_prod numeric, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 344 (class 1255 OID 18650)
-- Name: fn_insertar_empleado(integer, character varying, date, integer, date, character varying, character varying, numeric, character varying, character varying, character varying, character varying, date, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_empleado(p_ide_rol integer, p_cedula_empl character varying, p_fecha_nacimiento_empl date, p_edad_empl integer, p_fecha_inicio_empl date, p_primer_nombre_empl character varying, p_apellido_paterno_empl character varying, p_rmu_empl numeric DEFAULT 0, p_titulo_empl character varying DEFAULT 'libre'::character varying, p_estado_empl character varying DEFAULT 'inactivo'::character varying, p_segundo_nombre_empl character varying DEFAULT NULL::character varying, p_apellido_materno_empl character varying DEFAULT NULL::character varying, p_fecha_termino_empl date DEFAULT NULL::date, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO empleado(
        ide_rol, cedula_empl, fecha_nacimiento_empl, edad_empl, fecha_inicio_empl,
        primer_nombre_empl, apellido_paterno_empl, rmu_empl, titulo_empl, estado_empl,
        segundo_nombre_empl, apellido_materno_empl, fecha_termino_empl, usua_ingre
    ) VALUES (
        p_ide_rol, p_cedula_empl, p_fecha_nacimiento_empl, p_edad_empl, p_fecha_inicio_empl,
        p_primer_nombre_empl, p_apellido_paterno_empl, p_rmu_empl, p_titulo_empl, p_estado_empl,
        p_segundo_nombre_empl, p_apellido_materno_empl, p_fecha_termino_empl, p_usua_ingre
    ) RETURNING ide_empl INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empleado registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_empleado(p_ide_rol integer, p_cedula_empl character varying, p_fecha_nacimiento_empl date, p_edad_empl integer, p_fecha_inicio_empl date, p_primer_nombre_empl character varying, p_apellido_paterno_empl character varying, p_rmu_empl numeric, p_titulo_empl character varying, p_estado_empl character varying, p_segundo_nombre_empl character varying, p_apellido_materno_empl character varying, p_fecha_termino_empl date, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 311 (class 1255 OID 18651)
-- Name: fn_insertar_empresa(character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_empresa(p_nombre_empr character varying, p_responsable_empr character varying, p_fecha_contrato_empr timestamp without time zone, p_direccion_empr character varying, p_telefono_empr character varying, p_email_empr character varying, p_estado_empr character varying DEFAULT 'inactivo'::character varying, p_descripcion_empr character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO empresa(
        nombre_empr, responsable_empr, fecha_contrato_empr, direccion_empr, 
        telefono_empr, email_empr, estado_empr, descripcion_empr, usua_ingre
    ) VALUES (
        p_nombre_empr, p_responsable_empr, p_fecha_contrato_empr, p_direccion_empr,
        p_telefono_empr, p_email_empr, p_estado_empr, p_descripcion_empr, p_usua_ingre
    ) RETURNING ide_empr INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Empresa registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_empresa(p_nombre_empr character varying, p_responsable_empr character varying, p_fecha_contrato_empr timestamp without time zone, p_direccion_empr character varying, p_telefono_empr character varying, p_email_empr character varying, p_estado_empr character varying, p_descripcion_empr character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 391 (class 1255 OID 18652)
-- Name: fn_insertar_empresa_precios(integer, integer, numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_empresa_precios(p_ide_empr integer, p_ide_prod integer, p_precio_compra_prod numeric DEFAULT 0, p_dcto_compra_prod numeric DEFAULT 0, p_dcto_caducidad_prod numeric DEFAULT 0, p_iva_prod numeric DEFAULT 0, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO empresa_precios(
        ide_empr, ide_prod, precio_compra_prod, dcto_compra_prod,
        dcto_caducidad_prod, iva_prod, usua_ingre
    ) VALUES (
        p_ide_empr, p_ide_prod, p_precio_compra_prod, p_dcto_compra_prod,
        p_dcto_caducidad_prod, p_iva_prod, p_usua_ingre
    ) RETURNING ide_empr_prod INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Precio de empresa registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_empresa_precios(p_ide_empr integer, p_ide_prod integer, p_precio_compra_prod numeric, p_dcto_compra_prod numeric, p_dcto_caducidad_prod numeric, p_iva_prod numeric, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 341 (class 1255 OID 18653)
-- Name: fn_insertar_entrega(integer, integer, timestamp without time zone, integer, numeric, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_entrega(p_ide_pedi integer, p_ide_prov integer, p_fecha_entr timestamp without time zone, p_cantidad_total_entr integer, p_total_entr numeric DEFAULT 0, p_estado_entr character varying DEFAULT 'incompleto'::character varying, p_observacion_entr character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO entrega(
        ide_pedi, ide_prov, fecha_entr, cantidad_total_entr, total_entr,
        estado_entr, observacion_entr, usua_ingre
    ) VALUES (
        p_ide_pedi, p_ide_prov, p_fecha_entr, p_cantidad_total_entr, p_total_entr,
        p_estado_entr, p_observacion_entr, p_usua_ingre
    ) RETURNING ide_entr INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Entrega registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_entrega(p_ide_pedi integer, p_ide_prov integer, p_fecha_entr timestamp without time zone, p_cantidad_total_entr integer, p_total_entr numeric, p_estado_entr character varying, p_observacion_entr character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 357 (class 1255 OID 18654)
-- Name: fn_insertar_lote(integer, date, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_lote(p_ide_prod integer, p_fecha_caducidad_lote date, p_stock_lote integer, p_estado_lote character varying DEFAULT 'correcto'::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO lote(
        ide_prod, fecha_caducidad_lote, stock_lote, estado_lote
    ) VALUES (
        p_ide_prod, p_fecha_caducidad_lote, p_stock_lote, p_estado_lote
    ) RETURNING ide_lote INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Lote registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_lote(p_ide_prod integer, p_fecha_caducidad_lote date, p_stock_lote integer, p_estado_lote character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 361 (class 1255 OID 18655)
-- Name: fn_insertar_marca(character varying, character varying, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_marca(p_nombre_marc character varying, p_pais_origen_marc character varying, p_calidad_marc integer DEFAULT 1, p_descripcion_marc character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO marca(
        nombre_marc, pais_origen_marc, calidad_marc, descripcion_marc, usua_ingre
    ) VALUES (
        p_nombre_marc, p_pais_origen_marc, p_calidad_marc, p_descripcion_marc, p_usua_ingre
    ) RETURNING ide_marc INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Marca registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_marca(p_nombre_marc character varying, p_pais_origen_marc character varying, p_calidad_marc integer, p_descripcion_marc character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 18656)
-- Name: fn_insertar_opciones(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_opciones(p_nombre_opci character varying, p_ruta_opci character varying, p_activo_opci character varying DEFAULT 'no'::character varying, p_descripcion_opci character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO opciones(
        nombre_opci, ruta_opci, activo_opci, descripcion_opci, usua_ingre
    ) VALUES (
        p_nombre_opci, p_ruta_opci, p_activo_opci, p_descripcion_opci, p_usua_ingre
    ) RETURNING ide_opci INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Opción registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_opciones(p_nombre_opci character varying, p_ruta_opci character varying, p_activo_opci character varying, p_descripcion_opci character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 18657)
-- Name: fn_insertar_pedido(integer, timestamp without time zone, timestamp without time zone, integer, numeric, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_pedido(p_ide_empr integer, p_fecha_pedi timestamp without time zone, p_fecha_entr_pedi timestamp without time zone, p_cantidad_total_pedi integer, p_total_pedi numeric, p_estado_pedi character varying DEFAULT 'progreso'::character varying, p_motivo_pedi character varying DEFAULT 'peticion'::character varying, p_observacion_pedi character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO pedido(
        ide_empr, fecha_pedi, fecha_entr_pedi, cantidad_total_pedi, total_pedi,
        estado_pedi, motivo_pedi, observacion_pedi, usua_ingre
    ) VALUES (
        p_ide_empr, p_fecha_pedi, p_fecha_entr_pedi, p_cantidad_total_pedi, p_total_pedi,
        p_estado_pedi, p_motivo_pedi, p_observacion_pedi, p_usua_ingre
    ) RETURNING ide_pedi INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Pedido registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_pedido(p_ide_empr integer, p_fecha_pedi timestamp without time zone, p_fecha_entr_pedi timestamp without time zone, p_cantidad_total_pedi integer, p_total_pedi numeric, p_estado_pedi character varying, p_motivo_pedi character varying, p_observacion_pedi character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 371 (class 1255 OID 18658)
-- Name: fn_insertar_perfil(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_perfil(p_ide_rol integer, p_nombre_perf character varying, p_descripcion_perf character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO perfil(
        ide_rol, nombre_perf, descripcion_perf, usua_ingre
    ) VALUES (
        p_ide_rol, p_nombre_perf, p_descripcion_perf, p_usua_ingre
    ) RETURNING ide_perf INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Perfil registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_perfil(p_ide_rol integer, p_nombre_perf character varying, p_descripcion_perf character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 18659)
-- Name: fn_insertar_perfil_opciones(integer, integer, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_perfil_opciones(p_ide_perf integer, p_ide_opci integer, p_listar character varying DEFAULT 'no'::character varying, p_insertar character varying DEFAULT 'no'::character varying, p_modificar character varying DEFAULT 'no'::character varying, p_eliminar character varying DEFAULT 'no'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO perfil_opciones(
        ide_perf, ide_opci, listar, insertar, modificar, eliminar, usua_ingre
    ) VALUES (
        p_ide_perf, p_ide_opci, p_listar, p_insertar, p_modificar, p_eliminar, p_usua_ingre
    ) RETURNING ide_perf_opci INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Permiso de perfil registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_perfil_opciones(p_ide_perf integer, p_ide_opci integer, p_listar character varying, p_insertar character varying, p_modificar character varying, p_eliminar character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 18660)
-- Name: fn_insertar_producto(integer, integer, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_producto(p_ide_cate integer, p_ide_marc integer, p_codigo_barra_prod character varying, p_nombre_prod character varying, p_precio_compra_prod numeric DEFAULT 0, p_precio_venta_prod numeric DEFAULT 0, p_iva_prod numeric DEFAULT 0, p_dcto_promo_prod numeric DEFAULT 0, p_dcto_caduc_prod numeric DEFAULT 0, p_precio_final_prod numeric DEFAULT 0, p_stock_prod integer DEFAULT 0, p_disponible_prod character varying DEFAULT 'no'::character varying, p_estado_prod character varying DEFAULT 'inactivo'::character varying, p_descripcion_prod character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO producto(
        ide_cate, ide_marc, codigo_barra_prod, nombre_prod, precio_compra_prod,
        precio_venta_prod, iva_prod, dcto_promo_prod, dcto_caduc_prod, precio_final_prod,
        stock_prod, disponible_prod, estado_prod, descripcion_prod, usua_ingre
    ) VALUES (
        p_ide_cate, p_ide_marc, p_codigo_barra_prod, p_nombre_prod, p_precio_compra_prod,
        p_precio_venta_prod, p_iva_prod, p_dcto_promo_prod, p_dcto_caduc_prod, p_precio_final_prod,
        p_stock_prod, p_disponible_prod, p_estado_prod, p_descripcion_prod, p_usua_ingre
    ) RETURNING ide_prod INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Producto registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_producto(p_ide_cate integer, p_ide_marc integer, p_codigo_barra_prod character varying, p_nombre_prod character varying, p_precio_compra_prod numeric, p_precio_venta_prod numeric, p_iva_prod numeric, p_dcto_promo_prod numeric, p_dcto_caduc_prod numeric, p_precio_final_prod numeric, p_stock_prod integer, p_disponible_prod character varying, p_estado_prod character varying, p_descripcion_prod character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 302 (class 1255 OID 18661)
-- Name: fn_insertar_proveedor(integer, character varying, date, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_proveedor(p_ide_empr integer, p_cedula_prov character varying, p_fecha_nacimiento_prov date, p_edad_prov integer, p_telefono_prov character varying, p_email_prov character varying, p_primer_nombre_prov character varying, p_apellido_paterno_prov character varying, p_segundo_nombre_prov character varying DEFAULT NULL::character varying, p_apellido_materno_prov character varying DEFAULT NULL::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO proveedor(
        ide_empr, cedula_prov, fecha_nacimiento_prov, edad_prov, telefono_prov,
        email_prov, primer_nombre_prov, apellido_paterno_prov, segundo_nombre_prov,
        apellido_materno_prov, usua_ingre
    ) VALUES (
        p_ide_empr, p_cedula_prov, p_fecha_nacimiento_prov, p_edad_prov, p_telefono_prov,
        p_email_prov, p_primer_nombre_prov, p_apellido_paterno_prov, p_segundo_nombre_prov,
        p_apellido_materno_prov, p_usua_ingre
    ) RETURNING ide_prov INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Proveedor registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_proveedor(p_ide_empr integer, p_cedula_prov character varying, p_fecha_nacimiento_prov date, p_edad_prov integer, p_telefono_prov character varying, p_email_prov character varying, p_primer_nombre_prov character varying, p_apellido_paterno_prov character varying, p_segundo_nombre_prov character varying, p_apellido_materno_prov character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 18662)
-- Name: fn_insertar_rol(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_rol(p_nombre_rol character varying, p_descripcion_rol character varying DEFAULT 'Ninguna'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO rol(
        nombre_rol, descripcion_rol, usua_ingre
    ) VALUES (
        p_nombre_rol, p_descripcion_rol, p_usua_ingre
    ) RETURNING ide_rol INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Rol registrado correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_rol(p_nombre_rol character varying, p_descripcion_rol character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 18663)
-- Name: fn_insertar_venta(integer, integer, character varying, timestamp without time zone, integer, numeric, numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_insertar_venta(p_ide_empl integer, p_ide_clie integer, p_num_factura_vent character varying, p_fecha_vent timestamp without time zone, p_cantidad_vent integer, p_sub_total_vent numeric, p_total_vent numeric, p_dcto_vent numeric DEFAULT 0, p_estado_vent character varying DEFAULT 'completado'::character varying, p_usua_ingre character varying DEFAULT NULL::character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO venta(
        ide_empl, ide_clie, num_factura_vent, fecha_vent, cantidad_vent,
        sub_total_vent, dcto_vent, total_vent, estado_vent, usua_ingre
    ) VALUES (
        p_ide_empl, p_ide_clie, p_num_factura_vent, p_fecha_vent, p_cantidad_vent,
        p_sub_total_vent, p_dcto_vent, p_total_vent, p_estado_vent, p_usua_ingre
    ) RETURNING ide_vent INTO p_id;
    
    p_result := 1;
    p_response := '{"success": true, "message": "Venta registrada correctamente", "id": ' || p_id || '}';
EXCEPTION
    WHEN OTHERS THEN
        p_result := 0;
        p_id := NULL;
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_insertar_venta(p_ide_empl integer, p_ide_clie integer, p_num_factura_vent character varying, p_fecha_vent timestamp without time zone, p_cantidad_vent integer, p_sub_total_vent numeric, p_total_vent numeric, p_dcto_vent numeric, p_estado_vent character varying, p_usua_ingre character varying, OUT p_result integer, OUT p_id integer, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 318 (class 1255 OID 18664)
-- Name: fn_listar_acceso_usuario(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_acceso_usuario(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM acceso_usuario ORDER BY fecha_acce DESC;
    p_response := '{"success": true, "message": "Listado de accesos de usuario obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_acceso_usuario(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 18665)
-- Name: fn_listar_categoria(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_categoria(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM categoria ORDER BY nombre_cate;
    p_response := '{"success": true, "message": "Listado de categorías obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_categoria(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 314 (class 1255 OID 18666)
-- Name: fn_listar_cliente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_cliente(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM cliente ORDER BY apellido_paterno_clie, primer_nombre_clie;
    p_response := '{"success": true, "message": "Listado de clientes obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_cliente(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 384 (class 1255 OID 18667)
-- Name: fn_listar_cuenta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_cuenta(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM cuenta ORDER BY usuario_cuen;
    p_response := '{"success": true, "message": "Listado de cuentas obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_cuenta(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 386 (class 1255 OID 18668)
-- Name: fn_listar_detalle_entrega(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_detalle_entrega(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_entrega ORDER BY ide_deta_entr;
    p_response := '{"success": true, "message": "Listado de detalles de entrega obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_detalle_entrega(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 18669)
-- Name: fn_listar_detalle_pedido(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_detalle_pedido(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_pedido ORDER BY ide_deta_pedi;
    p_response := '{"success": true, "message": "Listado de detalles de pedido obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_detalle_pedido(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 355 (class 1255 OID 18670)
-- Name: fn_listar_detalle_venta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_detalle_venta(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM detalle_venta ORDER BY ide_deta_vent;
    p_response := '{"success": true, "message": "Listado de detalles de venta obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_detalle_venta(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 347 (class 1255 OID 18671)
-- Name: fn_listar_empleado(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_empleado(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM empleado ORDER BY apellido_paterno_empl, primer_nombre_empl;
    p_response := '{"success": true, "message": "Listado de empleados obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_empleado(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 336 (class 1255 OID 18672)
-- Name: fn_listar_empresa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_empresa(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT  
		ide_empr,
		nombre_empr,
		responsable_empr,
		TO_CHAR(fecha_contrato_empr AT TIME ZONE 'America/Guayaquil', 'DD/MM/YYYY HH24:MI') AS fecha_contrato_empr,
		direccion_empr,
		telefono_empr,
		email_empr,
		estado_empr,
		descripcion_empr
	FROM empresa ORDER BY nombre_empr;
    p_response := '{"success": true, "message": "Listado de empresas obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_empresa(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 372 (class 1255 OID 18673)
-- Name: fn_listar_empresa_precios(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_empresa_precios(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM empresa_precios ORDER BY ide_empr, ide_prod;
    p_response := '{"success": true, "message": "Listado de precios de empresa obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_empresa_precios(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 353 (class 1255 OID 18674)
-- Name: fn_listar_entrega(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_entrega(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM entrega ORDER BY fecha_entr DESC;
    p_response := '{"success": true, "message": "Listado de entregas obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_entrega(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 315 (class 1255 OID 18675)
-- Name: fn_listar_lote(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_lote(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM lote ORDER BY fecha_caducidad_lote;
    p_response := '{"success": true, "message": "Listado de lotes obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_lote(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 18676)
-- Name: fn_listar_marca(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_marca(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM marca ORDER BY nombre_marc;
    p_response := '{"success": true, "message": "Listado de marcas obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_marca(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 309 (class 1255 OID 18677)
-- Name: fn_listar_opciones(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_opciones(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM opciones ORDER BY nombre_opci;
    p_response := '{"success": true, "message": "Listado de opciones obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_opciones(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 312 (class 1255 OID 18678)
-- Name: fn_listar_pedido(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_pedido(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM pedido ORDER BY fecha_pedi DESC;
    p_response := '{"success": true, "message": "Listado de pedidos obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_pedido(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 345 (class 1255 OID 18679)
-- Name: fn_listar_perfil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_perfil(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM perfil ORDER BY nombre_perf;
    p_response := '{"success": true, "message": "Listado de perfiles obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_perfil(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 18680)
-- Name: fn_listar_perfil_opciones(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_perfil_opciones(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM perfil_opciones ORDER BY ide_perf, ide_opci;
    p_response := '{"success": true, "message": "Listado de permisos de perfil obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_perfil_opciones(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 18681)
-- Name: fn_listar_producto(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_producto(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM producto ORDER BY nombre_prod;
    p_response := '{"success": true, "message": "Listado de productos obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_producto(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 354 (class 1255 OID 18682)
-- Name: fn_listar_proveedor(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_proveedor(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM proveedor ORDER BY apellido_paterno_prov, primer_nombre_prov;
    p_response := '{"success": true, "message": "Listado de proveedores obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_proveedor(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 327 (class 1255 OID 18683)
-- Name: fn_listar_rol(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_rol(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM rol ORDER BY nombre_rol;
    p_response := '{"success": true, "message": "Listado de roles obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_rol(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 360 (class 1255 OID 18684)
-- Name: fn_listar_venta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_listar_venta(OUT p_result refcursor, OUT p_response text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    OPEN p_result FOR SELECT * FROM venta ORDER BY fecha_vent DESC;
    p_response := '{"success": true, "message": "Listado de ventas obtenido"}';
EXCEPTION
    WHEN OTHERS THEN
        p_response := '{"success": false, "message": "' || SQLERRM || '"}';
END;
$$;


ALTER FUNCTION public.fn_listar_venta(OUT p_result refcursor, OUT p_response text) OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 18685)
-- Name: obtener_rutas_json(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_rutas_json(ruta_id integer) RETURNS jsonb
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
  resultado JSONB;
BEGIN
  SELECT jsonb_build_object(
           'id', op.ide_opci,
           'titulo', op.nombre_opci,
		   'ruta', op.ruta_opci,
		   'activo', op.activo_opci,
           'hijas',
           COALESCE(
             (
               SELECT jsonb_agg(obtener_rutas_json(a.ide_opci))
               FROM opciones a
               WHERE a.padre_opci = op.ide_opci
			   AND a.activo_opci = 'si'
             ),
             '[]'::jsonb
           )
         )
  INTO resultado
  FROM opciones op
  WHERE op.ide_opci = ruta_id;

  RETURN resultado;
END;
$$;


ALTER FUNCTION public.obtener_rutas_json(ruta_id integer) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 18686)
-- Name: obtener_rutas_json(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_rutas_json(ruta_id integer, perfil_id integer) RETURNS jsonb
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
  resultado JSONB;
BEGIN
  SELECT jsonb_build_object(
           'id', op.ide_opci,
           'titulo', op.nombre_opci,
		   'ruta', op.ruta_opci,
		   'icono', op.icono_opci,
		   'activo', op.activo_opci,
           'hijas',
           COALESCE(
             (
               SELECT jsonb_agg(obtener_rutas_json(a.ide_opci))
               FROM opciones a
			   LEFT JOIN perfil_opciones b ON (b.ide_opci = a.ide_opci)
               WHERE b.ide_perf = perfil_id
			   AND a.padre_opci = op.ide_opci
			   AND a.activo_opci = 'si'
             ),
             '[]'::jsonb
           )
         )
  INTO resultado
  FROM opciones op
  WHERE op.ide_opci = ruta_id;

  RETURN resultado;
END;
$$;


ALTER FUNCTION public.obtener_rutas_json(ruta_id integer, perfil_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 18687)
-- Name: acceso_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acceso_usuario (
    ide_acce integer NOT NULL,
    ide_cuen integer NOT NULL,
    navegador_acce character varying(250) NOT NULL,
    fecha_acce timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    num_int_fall_acce integer DEFAULT 0 NOT NULL,
    ip_acce character varying(15) DEFAULT '999.999.999.999'::character varying NOT NULL,
    latitud_acce numeric(10,6),
    longitud_acce numeric(10,6),
    CONSTRAINT acceso_usuario_num_int_fall_acce_check CHECK ((num_int_fall_acce >= 0))
);


ALTER TABLE public.acceso_usuario OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 18699)
-- Name: acceso_usuario_ide_acce_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acceso_usuario_ide_acce_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.acceso_usuario_ide_acce_seq OWNER TO postgres;

--
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 220
-- Name: acceso_usuario_ide_acce_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acceso_usuario_ide_acce_seq OWNED BY public.acceso_usuario.ide_acce;


--
-- TOC entry 221 (class 1259 OID 18700)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    ide_cate integer NOT NULL,
    nombre_cate character varying(100) NOT NULL,
    descripcion_cate character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 18708)
-- Name: categoria_ide_cate_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_ide_cate_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_ide_cate_seq OWNER TO postgres;

--
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoria_ide_cate_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_ide_cate_seq OWNED BY public.categoria.ide_cate;


--
-- TOC entry 223 (class 1259 OID 18709)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    ide_clie integer NOT NULL,
    cedula_clie character varying(15) NOT NULL,
    fecha_nacimiento_clie date NOT NULL,
    edad_clie integer NOT NULL,
    telefono_clie character varying(15) NOT NULL,
    primer_nombre_clie character varying(50) NOT NULL,
    apellido_paterno_clie character varying(50) NOT NULL,
    email_clie character varying(100) DEFAULT 'Ninguno'::character varying NOT NULL,
    es_socio character varying(2) DEFAULT 'no'::character varying NOT NULL,
    es_tercera_edad character varying(2) DEFAULT 'no'::character varying NOT NULL,
    segundo_nombre_clie character varying(50),
    apellido_materno_clie character varying(50),
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT cliente_edad_clie_check CHECK ((edad_clie > 0)),
    CONSTRAINT cliente_es_socio_check CHECK (((es_socio)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text]))),
    CONSTRAINT cliente_es_tercera_edad_check CHECK (((es_tercera_edad)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text])))
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18729)
-- Name: cliente_ide_clie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_ide_clie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_ide_clie_seq OWNER TO postgres;

--
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 224
-- Name: cliente_ide_clie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_ide_clie_seq OWNED BY public.cliente.ide_clie;


--
-- TOC entry 225 (class 1259 OID 18730)
-- Name: cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta (
    ide_cuen integer NOT NULL,
    ide_empl integer NOT NULL,
    ide_perf integer NOT NULL,
    usuario_cuen character varying(25) NOT NULL,
    password_cuen character varying(250) NOT NULL,
    estado_cuen character varying(25) DEFAULT 'inactivo'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT cuenta_estado_cuen_check CHECK (((estado_cuen)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text, ('bloqueado'::character varying)::text])))
);


ALTER TABLE public.cuenta OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18742)
-- Name: cuenta_ide_cuen_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_ide_cuen_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuenta_ide_cuen_seq OWNER TO postgres;

--
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 226
-- Name: cuenta_ide_cuen_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_ide_cuen_seq OWNED BY public.cuenta.ide_cuen;


--
-- TOC entry 227 (class 1259 OID 18743)
-- Name: detalle_entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_entrega (
    ide_deta_entr integer NOT NULL,
    ide_entr integer NOT NULL,
    ide_prod integer NOT NULL,
    cantidad_prod integer NOT NULL,
    precio_unitario_prod numeric(10,2) DEFAULT 0 NOT NULL,
    subtotal_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_compra_prod numeric(10,2) DEFAULT 0 NOT NULL,
    iva_prod numeric(10,2) DEFAULT 0 NOT NULL,
    total_prod numeric(10,2),
    dcto_caduc_prod numeric(10,2),
    CONSTRAINT detalle_entrega_cantidad_prod_check CHECK ((cantidad_prod > 0)),
    CONSTRAINT detalle_entrega_dcto_prod_check CHECK ((dcto_compra_prod >= (0)::numeric)),
    CONSTRAINT detalle_entrega_iva_prod_check CHECK ((iva_prod >= (0)::numeric)),
    CONSTRAINT detalle_entrega_precio_unitario_prod_check CHECK ((precio_unitario_prod >= (0)::numeric)),
    CONSTRAINT detalle_entrega_subtotal_prod_check CHECK ((subtotal_prod >= (0)::numeric))
);


ALTER TABLE public.detalle_entrega OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18763)
-- Name: detalle_entrega_ide_deta_entr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_entrega_ide_deta_entr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_entrega_ide_deta_entr_seq OWNER TO postgres;

--
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 228
-- Name: detalle_entrega_ide_deta_entr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_entrega_ide_deta_entr_seq OWNED BY public.detalle_entrega.ide_deta_entr;


--
-- TOC entry 229 (class 1259 OID 18764)
-- Name: detalle_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_pedido (
    ide_deta_pedi integer NOT NULL,
    ide_pedi integer NOT NULL,
    ide_prod integer NOT NULL,
    cantidad_prod integer NOT NULL,
    precio_unitario_prod numeric(10,2) DEFAULT 0 NOT NULL,
    subtotal_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_compra_prod numeric(10,2) DEFAULT 0 NOT NULL,
    iva_prod numeric(10,2) DEFAULT 0 NOT NULL,
    total_prod numeric(10,2),
    dcto_caduc_prod numeric(10,2),
    CONSTRAINT detalle_pedido_cantidad_prod_check CHECK ((cantidad_prod > 0)),
    CONSTRAINT detalle_pedido_dcto_prod_check CHECK ((dcto_compra_prod >= (0)::numeric)),
    CONSTRAINT detalle_pedido_iva_prod_check CHECK ((iva_prod >= (0)::numeric)),
    CONSTRAINT detalle_pedido_precio_unitario_prod_check CHECK ((precio_unitario_prod >= (0)::numeric)),
    CONSTRAINT detalle_pedido_subtotal_prod_check CHECK ((subtotal_prod >= (0)::numeric))
);


ALTER TABLE public.detalle_pedido OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18784)
-- Name: detalle_pedido_ide_deta_pedi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_pedido_ide_deta_pedi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_pedido_ide_deta_pedi_seq OWNER TO postgres;

--
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 230
-- Name: detalle_pedido_ide_deta_pedi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_pedido_ide_deta_pedi_seq OWNED BY public.detalle_pedido.ide_deta_pedi;


--
-- TOC entry 231 (class 1259 OID 18785)
-- Name: detalle_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_venta (
    ide_deta_vent integer NOT NULL,
    ide_vent integer NOT NULL,
    ide_prod integer NOT NULL,
    cantidad_prod integer NOT NULL,
    precio_unitario_prod numeric(10,2) DEFAULT 0 NOT NULL,
    subtotal_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_promo numeric(10,2) DEFAULT 0 NOT NULL,
    iva_prod numeric(10,2) DEFAULT 0 NOT NULL,
    CONSTRAINT detalle_venta_cantidad_prod_check CHECK ((cantidad_prod > 0)),
    CONSTRAINT detalle_venta_dcto_prod_check CHECK ((dcto_prod >= (0)::numeric)),
    CONSTRAINT detalle_venta_dcto_promo_check CHECK ((dcto_promo >= (0)::numeric)),
    CONSTRAINT detalle_venta_iva_prod_check CHECK ((iva_prod >= (0)::numeric)),
    CONSTRAINT detalle_venta_precio_unitario_prod_check CHECK ((precio_unitario_prod >= (0)::numeric)),
    CONSTRAINT detalle_venta_subtotal_prod_check CHECK ((subtotal_prod >= (0)::numeric))
);


ALTER TABLE public.detalle_venta OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18808)
-- Name: detalle_venta_ide_deta_vent_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_venta_ide_deta_vent_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_venta_ide_deta_vent_seq OWNER TO postgres;

--
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 232
-- Name: detalle_venta_ide_deta_vent_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_venta_ide_deta_vent_seq OWNED BY public.detalle_venta.ide_deta_vent;


--
-- TOC entry 233 (class 1259 OID 18809)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    ide_empl integer NOT NULL,
    ide_rol integer NOT NULL,
    cedula_empl character varying(15) NOT NULL,
    fecha_nacimiento_empl date NOT NULL,
    edad_empl integer NOT NULL,
    fecha_inicio_empl date NOT NULL,
    primer_nombre_empl character varying(50) NOT NULL,
    apellido_paterno_empl character varying(50) NOT NULL,
    rmu_empl numeric(10,2) DEFAULT 0 NOT NULL,
    titulo_empl character varying(250) DEFAULT 'libre'::character varying NOT NULL,
    estado_empl character varying(25) DEFAULT 'inactivo'::character varying NOT NULL,
    segundo_nombre_empl character varying(50),
    apellido_materno_empl character varying(50),
    fecha_termino_empl date,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT empleado_edad_empl_check CHECK ((edad_empl > 0)),
    CONSTRAINT empleado_estado_empl_check CHECK (((estado_empl)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text]))),
    CONSTRAINT empleado_rmu_empl_check CHECK ((rmu_empl >= (0)::numeric))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18832)
-- Name: empleado_ide_empl_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleado_ide_empl_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleado_ide_empl_seq OWNER TO postgres;

--
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 234
-- Name: empleado_ide_empl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleado_ide_empl_seq OWNED BY public.empleado.ide_empl;


--
-- TOC entry 235 (class 1259 OID 18833)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    ide_empr integer NOT NULL,
    nombre_empr character varying(250) NOT NULL,
    responsable_empr character varying(250) NOT NULL,
    fecha_contrato_empr timestamp without time zone NOT NULL,
    direccion_empr character varying(250) NOT NULL,
    telefono_empr character varying(15) NOT NULL,
    email_empr character varying(100) NOT NULL,
    estado_empr character varying(25) DEFAULT 'inactivo'::character varying NOT NULL,
    descripcion_empr character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT empresa_estado_empr_check CHECK (((estado_empr)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text])))
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18851)
-- Name: empresa_ide_empr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_ide_empr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresa_ide_empr_seq OWNER TO postgres;

--
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 236
-- Name: empresa_ide_empr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_ide_empr_seq OWNED BY public.empresa.ide_empr;


--
-- TOC entry 237 (class 1259 OID 18852)
-- Name: empresa_precios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa_precios (
    ide_empr_prod integer NOT NULL,
    ide_empr integer NOT NULL,
    ide_prod integer NOT NULL,
    precio_compra_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_compra_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_caducidad_prod numeric(10,2) DEFAULT 0 NOT NULL,
    iva_prod numeric(10,2) DEFAULT 0 NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT empresa_precios_precio_compra_prod_check CHECK ((precio_compra_prod >= (0)::numeric))
);


ALTER TABLE public.empresa_precios OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18868)
-- Name: empresa_precios_ide_empr_prod_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_precios_ide_empr_prod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresa_precios_ide_empr_prod_seq OWNER TO postgres;

--
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_precios_ide_empr_prod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_precios_ide_empr_prod_seq OWNED BY public.empresa_precios.ide_empr_prod;


--
-- TOC entry 239 (class 1259 OID 18869)
-- Name: entrega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrega (
    ide_entr integer NOT NULL,
    ide_pedi integer NOT NULL,
    ide_prov integer NOT NULL,
    fecha_entr timestamp without time zone NOT NULL,
    cantidad_total_entr integer NOT NULL,
    total_entr numeric(10,2) DEFAULT 0 NOT NULL,
    estado_entr character varying(25) DEFAULT 'incompleto'::character varying NOT NULL,
    observacion_entr character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT entrega_cantidad_total_entr_check CHECK ((cantidad_total_entr > 0)),
    CONSTRAINT entrega_estado_entr_check CHECK (((estado_entr)::text = ANY (ARRAY[('completo'::character varying)::text, ('incompleto'::character varying)::text]))),
    CONSTRAINT entrega_total_entr_check CHECK ((total_entr >= (0)::numeric))
);


ALTER TABLE public.entrega OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 18887)
-- Name: entrega_ide_entr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entrega_ide_entr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entrega_ide_entr_seq OWNER TO postgres;

--
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 240
-- Name: entrega_ide_entr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entrega_ide_entr_seq OWNED BY public.entrega.ide_entr;


--
-- TOC entry 241 (class 1259 OID 18888)
-- Name: lote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lote (
    ide_lote integer NOT NULL,
    ide_prod integer NOT NULL,
    fecha_caducidad_lote date NOT NULL,
    stock_lote integer DEFAULT 0 NOT NULL,
    estado_lote character varying(25) DEFAULT 'correcto'::character varying NOT NULL,
    CONSTRAINT lote_estado_lote_check CHECK (((estado_lote)::text = ANY (ARRAY[('correcto'::character varying)::text, ('proximo'::character varying)::text, ('caducado'::character varying)::text, ('devuelto'::character varying)::text]))),
    CONSTRAINT lote_stock_lote_check CHECK ((stock_lote >= 0))
);


ALTER TABLE public.lote OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 18900)
-- Name: lote_ide_lote_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lote_ide_lote_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lote_ide_lote_seq OWNER TO postgres;

--
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 242
-- Name: lote_ide_lote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lote_ide_lote_seq OWNED BY public.lote.ide_lote;


--
-- TOC entry 243 (class 1259 OID 18901)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    ide_marc integer NOT NULL,
    nombre_marc character varying(100) NOT NULL,
    pais_origen_marc character varying(100) NOT NULL,
    calidad_marc integer DEFAULT 1 NOT NULL,
    descripcion_marc character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT marca_calidad_marc_check CHECK (((calidad_marc >= 1) AND (calidad_marc <= 10)))
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 18915)
-- Name: marca_ide_marc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marca_ide_marc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marca_ide_marc_seq OWNER TO postgres;

--
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 244
-- Name: marca_ide_marc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marca_ide_marc_seq OWNED BY public.marca.ide_marc;


--
-- TOC entry 245 (class 1259 OID 18916)
-- Name: opciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opciones (
    ide_opci integer NOT NULL,
    nombre_opci character varying(100) NOT NULL,
    ruta_opci character varying(500) NOT NULL,
    activo_opci character varying(2) DEFAULT 'no'::character varying NOT NULL,
    descripcion_opci character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    nivel_opci integer,
    padre_opci integer,
    icono_opci character varying(50),
    CONSTRAINT opciones_activo_opci_check CHECK (((activo_opci)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text])))
);


ALTER TABLE public.opciones OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 18930)
-- Name: opciones_ide_opci_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opciones_ide_opci_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.opciones_ide_opci_seq OWNER TO postgres;

--
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 246
-- Name: opciones_ide_opci_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opciones_ide_opci_seq OWNED BY public.opciones.ide_opci;


--
-- TOC entry 247 (class 1259 OID 18931)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedido (
    ide_pedi integer NOT NULL,
    ide_empr integer NOT NULL,
    fecha_pedi timestamp without time zone NOT NULL,
    fecha_entr_pedi timestamp without time zone NOT NULL,
    cantidad_total_pedi integer NOT NULL,
    total_pedi numeric(10,2) DEFAULT 0 NOT NULL,
    estado_pedi character varying(25) DEFAULT 'progreso'::character varying NOT NULL,
    motivo_pedi character varying(25) DEFAULT 'peticion'::character varying NOT NULL,
    observacion_pedi character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT pedido_cantidad_total_pedi_check CHECK ((cantidad_total_pedi > 0)),
    CONSTRAINT pedido_estado_pedi_check CHECK (((estado_pedi)::text = ANY (ARRAY[('progreso'::character varying)::text, ('completado'::character varying)::text, ('incompleto'::character varying)::text]))),
    CONSTRAINT pedido_motivo_pedi_check CHECK (((motivo_pedi)::text = ANY (ARRAY[('peticion'::character varying)::text, ('devolucion'::character varying)::text]))),
    CONSTRAINT pedido_total_pedi_check CHECK ((total_pedi >= (0)::numeric))
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 18952)
-- Name: pedido_ide_pedi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedido_ide_pedi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_ide_pedi_seq OWNER TO postgres;

--
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 248
-- Name: pedido_ide_pedi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedido_ide_pedi_seq OWNED BY public.pedido.ide_pedi;


--
-- TOC entry 249 (class 1259 OID 18953)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    ide_perf integer NOT NULL,
    ide_rol integer NOT NULL,
    nombre_perf character varying(100) NOT NULL,
    descripcion_perf character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 18962)
-- Name: perfil_ide_perf_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_ide_perf_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perfil_ide_perf_seq OWNER TO postgres;

--
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 250
-- Name: perfil_ide_perf_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_ide_perf_seq OWNED BY public.perfil.ide_perf;


--
-- TOC entry 251 (class 1259 OID 18963)
-- Name: perfil_opciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil_opciones (
    ide_perf_opci integer NOT NULL,
    ide_perf integer NOT NULL,
    ide_opci integer NOT NULL,
    listar character varying(2) DEFAULT 'no'::character varying NOT NULL,
    insertar character varying(2) DEFAULT 'no'::character varying NOT NULL,
    modificar character varying(2) DEFAULT 'no'::character varying NOT NULL,
    eliminar character varying(2) DEFAULT 'no'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT perfil_opciones_eliminar_check CHECK (((eliminar)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text]))),
    CONSTRAINT perfil_opciones_insertar_check CHECK (((insertar)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text]))),
    CONSTRAINT perfil_opciones_listar_check CHECK (((listar)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text]))),
    CONSTRAINT perfil_opciones_modificar_check CHECK (((modificar)::text = ANY (ARRAY[('si'::character varying)::text, ('no'::character varying)::text])))
);


ALTER TABLE public.perfil_opciones OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 18982)
-- Name: perfil_opciones_ide_perf_opci_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfil_opciones_ide_perf_opci_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perfil_opciones_ide_perf_opci_seq OWNER TO postgres;

--
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 252
-- Name: perfil_opciones_ide_perf_opci_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfil_opciones_ide_perf_opci_seq OWNED BY public.perfil_opciones.ide_perf_opci;


--
-- TOC entry 253 (class 1259 OID 18983)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    ide_prod integer NOT NULL,
    ide_cate integer NOT NULL,
    ide_marc integer NOT NULL,
    codigo_barra_prod character varying(30) NOT NULL,
    nombre_prod character varying(100) NOT NULL,
    precio_compra_prod numeric(10,2) DEFAULT 0 NOT NULL,
    precio_venta_prod numeric(10,2) DEFAULT 0 NOT NULL,
    iva_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_promo_prod numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_caduc_prod numeric(10,2) DEFAULT 0 NOT NULL,
    precio_final_prod numeric(10,2) DEFAULT 0 NOT NULL,
    stock_prod integer DEFAULT 0 NOT NULL,
    disponible_prod character varying(25) DEFAULT 'no'::character varying NOT NULL,
    estado_prod character varying(25) DEFAULT 'inactivo'::character varying NOT NULL,
    descripcion_prod character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    url_img_prod character varying(500),
    CONSTRAINT producto_dcto_caduc_prod_check CHECK ((dcto_caduc_prod >= (0)::numeric)),
    CONSTRAINT producto_dcto_promo_prod_check CHECK ((dcto_promo_prod >= (0)::numeric)),
    CONSTRAINT producto_estado_prod_check CHECK (((estado_prod)::text = ANY (ARRAY[('activo'::character varying)::text, ('inactivo'::character varying)::text]))),
    CONSTRAINT producto_iva_prod_check CHECK ((iva_prod >= (0)::numeric)),
    CONSTRAINT producto_precio_compra_prod_check CHECK ((precio_compra_prod >= (0)::numeric)),
    CONSTRAINT producto_precio_final_prod_check CHECK ((precio_final_prod >= (0)::numeric)),
    CONSTRAINT producto_precio_venta_prod_check CHECK ((precio_venta_prod >= (0)::numeric)),
    CONSTRAINT producto_stock_prod_check CHECK ((stock_prod >= 0))
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 19022)
-- Name: producto_ide_prod_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_ide_prod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_ide_prod_seq OWNER TO postgres;

--
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 254
-- Name: producto_ide_prod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_ide_prod_seq OWNED BY public.producto.ide_prod;


--
-- TOC entry 255 (class 1259 OID 19023)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedor (
    ide_prov integer NOT NULL,
    ide_empr integer NOT NULL,
    cedula_prov character varying(15) NOT NULL,
    fecha_nacimiento_prov date NOT NULL,
    edad_prov integer NOT NULL,
    telefono_prov character varying(15) NOT NULL,
    email_prov character varying(100) NOT NULL,
    primer_nombre_prov character varying(50) NOT NULL,
    apellido_paterno_prov character varying(50) NOT NULL,
    segundo_nombre_prov character varying(50),
    apellido_materno_prov character varying(50),
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT proveedor_edad_prov_check CHECK ((edad_prov > 0))
);


ALTER TABLE public.proveedor OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 19037)
-- Name: proveedor_ide_prov_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedor_ide_prov_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proveedor_ide_prov_seq OWNER TO postgres;

--
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 256
-- Name: proveedor_ide_prov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedor_ide_prov_seq OWNED BY public.proveedor.ide_prov;


--
-- TOC entry 257 (class 1259 OID 19038)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    ide_rol integer NOT NULL,
    nombre_rol character varying(100) NOT NULL,
    descripcion_rol character varying(250) DEFAULT 'Ninguna'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 19046)
-- Name: rol_ide_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_ide_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rol_ide_rol_seq OWNER TO postgres;

--
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 258
-- Name: rol_ide_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_ide_rol_seq OWNED BY public.rol.ide_rol;


--
-- TOC entry 259 (class 1259 OID 19047)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    ide_vent integer NOT NULL,
    ide_empl integer NOT NULL,
    ide_clie integer NOT NULL,
    num_factura_vent character varying(25) NOT NULL,
    fecha_vent timestamp without time zone NOT NULL,
    cantidad_vent integer NOT NULL,
    sub_total_vent numeric(10,2) DEFAULT 0 NOT NULL,
    total_vent numeric(10,2) DEFAULT 0 NOT NULL,
    dcto_vent numeric(10,2) DEFAULT 0 NOT NULL,
    estado_vent character varying(25) DEFAULT 'completado'::character varying NOT NULL,
    usua_ingre character varying(25),
    fecha_ingre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usua_actua character varying(25),
    fecha_actua timestamp without time zone,
    CONSTRAINT venta_cantidad_vent_check CHECK ((cantidad_vent > 0)),
    CONSTRAINT venta_dcto_vent_check CHECK ((dcto_vent >= (0)::numeric)),
    CONSTRAINT venta_estado_vent_check CHECK (((estado_vent)::text = ANY (ARRAY[('completado'::character varying)::text, ('cancelado'::character varying)::text, ('devuelto'::character varying)::text]))),
    CONSTRAINT venta_sub_total_vent_check CHECK ((sub_total_vent >= (0)::numeric)),
    CONSTRAINT venta_total_vent_check CHECK ((total_vent >= (0)::numeric))
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 19070)
-- Name: venta_ide_vent_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_ide_vent_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venta_ide_vent_seq OWNER TO postgres;

--
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 260
-- Name: venta_ide_vent_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_ide_vent_seq OWNED BY public.venta.ide_vent;


--
-- TOC entry 5084 (class 2604 OID 19071)
-- Name: acceso_usuario ide_acce; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acceso_usuario ALTER COLUMN ide_acce SET DEFAULT nextval('public.acceso_usuario_ide_acce_seq'::regclass);


--
-- TOC entry 5088 (class 2604 OID 19072)
-- Name: categoria ide_cate; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN ide_cate SET DEFAULT nextval('public.categoria_ide_cate_seq'::regclass);


--
-- TOC entry 5091 (class 2604 OID 19073)
-- Name: cliente ide_clie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN ide_clie SET DEFAULT nextval('public.cliente_ide_clie_seq'::regclass);


--
-- TOC entry 5096 (class 2604 OID 19074)
-- Name: cuenta ide_cuen; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta ALTER COLUMN ide_cuen SET DEFAULT nextval('public.cuenta_ide_cuen_seq'::regclass);


--
-- TOC entry 5099 (class 2604 OID 19075)
-- Name: detalle_entrega ide_deta_entr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_entrega ALTER COLUMN ide_deta_entr SET DEFAULT nextval('public.detalle_entrega_ide_deta_entr_seq'::regclass);


--
-- TOC entry 5104 (class 2604 OID 19076)
-- Name: detalle_pedido ide_deta_pedi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido ALTER COLUMN ide_deta_pedi SET DEFAULT nextval('public.detalle_pedido_ide_deta_pedi_seq'::regclass);


--
-- TOC entry 5109 (class 2604 OID 19077)
-- Name: detalle_venta ide_deta_vent; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta ALTER COLUMN ide_deta_vent SET DEFAULT nextval('public.detalle_venta_ide_deta_vent_seq'::regclass);


--
-- TOC entry 5115 (class 2604 OID 19078)
-- Name: empleado ide_empl; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado ALTER COLUMN ide_empl SET DEFAULT nextval('public.empleado_ide_empl_seq'::regclass);


--
-- TOC entry 5120 (class 2604 OID 19079)
-- Name: empresa ide_empr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN ide_empr SET DEFAULT nextval('public.empresa_ide_empr_seq'::regclass);


--
-- TOC entry 5124 (class 2604 OID 19080)
-- Name: empresa_precios ide_empr_prod; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_precios ALTER COLUMN ide_empr_prod SET DEFAULT nextval('public.empresa_precios_ide_empr_prod_seq'::regclass);


--
-- TOC entry 5130 (class 2604 OID 19081)
-- Name: entrega ide_entr; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega ALTER COLUMN ide_entr SET DEFAULT nextval('public.entrega_ide_entr_seq'::regclass);


--
-- TOC entry 5135 (class 2604 OID 19082)
-- Name: lote ide_lote; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote ALTER COLUMN ide_lote SET DEFAULT nextval('public.lote_ide_lote_seq'::regclass);


--
-- TOC entry 5138 (class 2604 OID 19083)
-- Name: marca ide_marc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca ALTER COLUMN ide_marc SET DEFAULT nextval('public.marca_ide_marc_seq'::regclass);


--
-- TOC entry 5142 (class 2604 OID 19084)
-- Name: opciones ide_opci; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opciones ALTER COLUMN ide_opci SET DEFAULT nextval('public.opciones_ide_opci_seq'::regclass);


--
-- TOC entry 5146 (class 2604 OID 19085)
-- Name: pedido ide_pedi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido ALTER COLUMN ide_pedi SET DEFAULT nextval('public.pedido_ide_pedi_seq'::regclass);


--
-- TOC entry 5152 (class 2604 OID 19086)
-- Name: perfil ide_perf; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil ALTER COLUMN ide_perf SET DEFAULT nextval('public.perfil_ide_perf_seq'::regclass);


--
-- TOC entry 5155 (class 2604 OID 19087)
-- Name: perfil_opciones ide_perf_opci; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_opciones ALTER COLUMN ide_perf_opci SET DEFAULT nextval('public.perfil_opciones_ide_perf_opci_seq'::regclass);


--
-- TOC entry 5161 (class 2604 OID 19088)
-- Name: producto ide_prod; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto ALTER COLUMN ide_prod SET DEFAULT nextval('public.producto_ide_prod_seq'::regclass);


--
-- TOC entry 5173 (class 2604 OID 19089)
-- Name: proveedor ide_prov; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor ALTER COLUMN ide_prov SET DEFAULT nextval('public.proveedor_ide_prov_seq'::regclass);


--
-- TOC entry 5175 (class 2604 OID 19090)
-- Name: rol ide_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN ide_rol SET DEFAULT nextval('public.rol_ide_rol_seq'::regclass);


--
-- TOC entry 5178 (class 2604 OID 19091)
-- Name: venta ide_vent; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta ALTER COLUMN ide_vent SET DEFAULT nextval('public.venta_ide_vent_seq'::regclass);


--
-- TOC entry 5464 (class 0 OID 18687)
-- Dependencies: 219
-- Data for Name: acceso_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acceso_usuario (ide_acce, ide_cuen, navegador_acce, fecha_acce, num_int_fall_acce, ip_acce, latitud_acce, longitud_acce) FROM stdin;
\.


--
-- TOC entry 5466 (class 0 OID 18700)
-- Dependencies: 221
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (ide_cate, nombre_cate, descripcion_cate, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	peliculas y series	Ninguna	jsanchez	2025-11-22 16:56:48.277953	\N	\N
\.


--
-- TOC entry 5468 (class 0 OID 18709)
-- Dependencies: 223
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (ide_clie, cedula_clie, fecha_nacimiento_clie, edad_clie, telefono_clie, primer_nombre_clie, apellido_paterno_clie, email_clie, es_socio, es_tercera_edad, segundo_nombre_clie, apellido_materno_clie, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
0	9999999999	2000-01-01	25	9999999999	CONSUMIDOR	FINAL	cliente@email.com	no	no	\N	\N	admin	2025-10-06 18:19:00	\N	\N
1	0707329884	2003-12-01	21	0981347564	jonathan	chalco	jonatgfhan@gmail.com	no	no	joseph	berrezueta	lcordero	2025-11-22 16:34:04.162784	\N	\N
3	0734762334	2000-12-12	25	0923546782	kevin	jaramillo	kevin@gmail.com	no	si	anthony	rocafuerte	lcordero	2025-11-22 16:39:39.980455	\N	\N
4	0732567993	1950-01-01	75	0923547854	jostyn	velez	jostyn@gmail.com	si	si	jordan	montecarlo	lcordero	2025-11-22 16:42:27.977549	\N	\N
2	0745564389	1940-12-12	85	0954672398	juanito	perez	juan@gmail.com	si	no	lucas	pereira	lcordero	2025-11-22 16:36:54.207836	\N	\N
\.


--
-- TOC entry 5470 (class 0 OID 18730)
-- Dependencies: 225
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta (ide_cuen, ide_empl, ide_perf, usuario_cuen, password_cuen, estado_cuen, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
0	0	0	admin	$2a$12$ud.lg5Qhq3nWVM0Gf8HjZu06XIgFi6OtgKLhzAsnreck3L9Hfv4zq	activo	admin	2025-10-06 18:12:00	\N	\N
1	1	1	cvelez	$2a$12$bp43xEFgDt6gXp0TTuXYbefVvxG6V8ZE9Y9CXPUirz.4rsPMuj/X.	activo	admin	2025-10-06 18:13:00	\N	\N
2	2	2	jsanchez	$2a$12$/5BYQTGZx19ZWMhsGFlxROP4lYrTSMlvfBFjy7r0sov9NiwAg2s2y	activo	admin	2025-10-06 18:14:00	\N	\N
4	4	4	acorrea	$2a$12$c42z7tqR1a6WdohedFzLzOOJDPuKWVXKpFoqFO29ocDkDOEuHjQXO	activo	admin	2025-10-06 18:15:00	\N	\N
5	5	5	lcordero	$2a$12$ar9tCLS0uBQ4u.0kTl3NnOpiO8gmFz5nVvznKy7dQzzmBol5jExDi	activo	admin	2025-10-06 18:16:00	\N	\N
3	3	3	jchalco	$2a$12$dAyREQlpLYg8agSSZ55icuM11eRmCyAl27A1vWns.CSpJBndhYheq	activo	admin	2025-10-06 18:15:00	\N	\N
\.


--
-- TOC entry 5472 (class 0 OID 18743)
-- Dependencies: 227
-- Data for Name: detalle_entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_entrega (ide_deta_entr, ide_entr, ide_prod, cantidad_prod, precio_unitario_prod, subtotal_prod, dcto_compra_prod, iva_prod, total_prod, dcto_caduc_prod) FROM stdin;
1	1	1	50	0.50	25.00	0.00	2.50	27.50	0.00
\.


--
-- TOC entry 5474 (class 0 OID 18764)
-- Dependencies: 229
-- Data for Name: detalle_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_pedido (ide_deta_pedi, ide_pedi, ide_prod, cantidad_prod, precio_unitario_prod, subtotal_prod, dcto_compra_prod, iva_prod, total_prod, dcto_caduc_prod) FROM stdin;
1	1	1	50	0.50	25.00	0.00	2.50	27.50	0.00
\.


--
-- TOC entry 5476 (class 0 OID 18785)
-- Dependencies: 231
-- Data for Name: detalle_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_venta (ide_deta_vent, ide_vent, ide_prod, cantidad_prod, precio_unitario_prod, subtotal_prod, dcto_prod, dcto_promo, iva_prod) FROM stdin;
\.


--
-- TOC entry 5478 (class 0 OID 18809)
-- Dependencies: 233
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleado (ide_empl, ide_rol, cedula_empl, fecha_nacimiento_empl, edad_empl, fecha_inicio_empl, primer_nombre_empl, apellido_paterno_empl, rmu_empl, titulo_empl, estado_empl, segundo_nombre_empl, apellido_materno_empl, fecha_termino_empl, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
0	0	99999999	2000-01-01	25	2022-01-01	admin	sudo	0.00	administrador_sistema	activo	\N	\N	\N	admin	2025-10-02 13:56:00	\N	\N
1	1	0707329881	2001-01-01	24	2023-01-01	Carlos	Velez	1000.00	Ing. industrial	activo	Juan	Perez	\N	acorrea	2025-10-06 17:59:00	\N	\N
3	3	0707329884	2003-12-01	21	2025-01-01	Jonathan	Chalco	0.00	Estudiante de TI	activo	Joseph	Berrezueta	\N	acorrea	2025-10-06 18:03:00	\N	\N
4	4	0707329883	2004-01-01	21	2023-01-01	Andres	Correa	1000.00	Ing. en administración de empresas	activo	Jhon	Aguilar	\N	acorrea	2025-10-06 18:07:00	\N	\N
2	2	0707329882	2002-01-01	23	2024-01-01	Joaquin	Sanchez	800.00	Ing. en Marketing	activo	Moises	Caicedo	\N	acorrea	2025-10-06 18:00:00	\N	\N
5	5	0707329885	1999-01-01	26	2015-01-01	Luis	Cordero	500.00	Estudiante de Marketing	activo	Elias	Valencia	\N	acorrea	2025-10-06 18:08:00	\N	\N
\.


--
-- TOC entry 5480 (class 0 OID 18833)
-- Dependencies: 235
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (ide_empr, nombre_empr, responsable_empr, fecha_contrato_empr, direccion_empr, telefono_empr, email_empr, estado_empr, descripcion_empr, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	nestle	mario astudillo	2025-10-07 18:00:00	machala por la aurora	0981347564	nestle@gmail.com	activo	ninguna	cvelez	2025-10-08 00:23:41.121646	\N	\N
2	pronaca	diego molina	2025-10-01 15:00:00	guayaquil por los sauces	0981457538	pronaca@gmail.com	activo	ninguna	cvelez	2025-11-22 16:25:59.006849	\N	\N
3	pelis-movies .sa	carlos ruiz	2025-10-04 17:30:00	pichincha, quito, en la mitad del mundo	0976459804	movies@gmail.com	activo	ninguna	cvelez	2025-11-22 16:30:57.271324	\N	\N
\.


--
-- TOC entry 5482 (class 0 OID 18852)
-- Dependencies: 237
-- Data for Name: empresa_precios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa_precios (ide_empr_prod, ide_empr, ide_prod, precio_compra_prod, dcto_compra_prod, dcto_caducidad_prod, iva_prod, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	3	1	0.50	0.00	0.00	10.00	cvelez	2025-11-22 17:40:01.057646	\N	\N
\.


--
-- TOC entry 5484 (class 0 OID 18869)
-- Dependencies: 239
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrega (ide_entr, ide_pedi, ide_prov, fecha_entr, cantidad_total_entr, total_entr, estado_entr, observacion_entr, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	1	1	2025-10-15 00:00:00	1	27.50	completo	Ninguna	cvelez	2025-11-22 17:50:11.924489	\N	\N
\.


--
-- TOC entry 5486 (class 0 OID 18888)
-- Dependencies: 241
-- Data for Name: lote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lote (ide_lote, ide_prod, fecha_caducidad_lote, stock_lote, estado_lote) FROM stdin;
\.


--
-- TOC entry 5488 (class 0 OID 18901)
-- Dependencies: 243
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marca (ide_marc, nombre_marc, pais_origen_marc, calidad_marc, descripcion_marc, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	ecu-dvd	ecuador	10	la mejor marca de discos del mundo	jsanchez	2025-11-22 17:00:15.099419	\N	\N
\.


--
-- TOC entry 5490 (class 0 OID 18916)
-- Dependencies: 245
-- Data for Name: opciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opciones (ide_opci, nombre_opci, ruta_opci, activo_opci, descripcion_opci, usua_ingre, fecha_ingre, usua_actua, fecha_actua, nivel_opci, padre_opci, icono_opci) FROM stdin;
17	Bodega	/admin/bodega	si	Nivel Bodega	admin	2025-10-02 14:24:00	\N	\N	0	\N	forklift
22	Proveedores	/admin/proveedores	si	Nivel Proveedores	admin	2025-10-06 17:28:00	\N	\N	0	\N	local_shipping
10	Proveedores	/admin/proveedores/proveedores	si	Pantalla Proveedores	admin	2025-10-02 14:10:00	\N	\N	1	22	\N
1	Entregas	/admin/bodega/entregas	si	Pantalla Entregas	admin	2025-10-02 14:01:00	\N	\N	1	17	\N
2	Pedidos	/admin/bodega/pedidos	si	Pantalla Pedidos	admin	2025-10-02 14:04:00	\N	\N	1	17	\N
3	Empleados	/admin/nomina/empleados	si	Pantalla Empleados	admin	2025-10-02 14:04:00	\N	\N	1	18	\N
4	Roles	/admin/nomina/roles	si	Pantalla Roles	admin	2025-10-02 14:05:00	\N	\N	1	18	\N
5	Categorias	/admin/productos/categorias	si	Pantalla Categorias	admin	2025-10-02 14:06:00	\N	\N	1	19	\N
6	Lotes	/admin/productos/lotes	si	Pantalla Lotes	admin	2025-10-02 14:06:00	\N	\N	1	19	\N
7	Marcas	/admin/productos/marcas	si	Pantalla Marcas	admin	2025-10-02 14:08:00	\N	\N	1	19	\N
8	Productos	/admin/productos/productos	si	Pantalla Productos	admin	2025-10-02 14:08:00	\N	\N	1	19	\N
15	Clientes	/admin/ventas/clientes	si	Pantalla Clientes	admin	2025-10-02 14:15:00	\N	\N	1	21	\N
16	Ventas	/admin/ventas/ventas	si	Pantalla Ventas	admin	2025-10-02 14:18:00	\N	\N	1	21	\N
11	Accesos	/admin/seguridad/accesos	si	Pantalla Accesos	admin	2025-10-02 14:10:00	\N	\N	1	20	\N
12	Cuentas	/admin/seguridad/cuentas	si	Pantalla Cuentas	admin	2025-10-02 14:11:00	\N	\N	1	20	\N
13	Opciones	/admin/seguridad/opciones	si	Pantalla Opciones	admin	2025-10-02 14:14:00	\N	\N	1	20	\N
14	Perfiles	/admin/seguridad/perfiles	si	Pantalla Perfiles	admin	2025-10-02 14:14:00	\N	\N	1	20	\N
9	Empresas	/admin/proveedores/empresas	si	Pantalla Empresas	admin	2025-10-02 14:09:00	\N	\N	1	22	\N
18	Nomina	/admin/nomina	si	Nivel Nomina	admin	2025-10-02 14:28:00	\N	\N	0	\N	badge
19	Productos	/admin/productos	si	Nivel Productos	admin	2025-10-02 14:29:00	\N	\N	0	\N	local_mall
20	Seguridad	/admin/seguridad	si	Nivel Seguridad	admin	2025-10-02 14:29:00	\N	\N	0	\N	security
21	Ventas	/admin/ventas	si	Nivel Ventas	admin	2025-10-02 14:30:00	\N	\N	0	\N	point_of_sale
\.


--
-- TOC entry 5492 (class 0 OID 18931)
-- Dependencies: 247
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido (ide_pedi, ide_empr, fecha_pedi, fecha_entr_pedi, cantidad_total_pedi, total_pedi, estado_pedi, motivo_pedi, observacion_pedi, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	3	2025-10-10 00:00:00	2025-10-15 00:00:00	1	27.50	completado	peticion	Ninguna	cvelez	2025-11-22 16:55:11.341604	\N	\N
\.


--
-- TOC entry 5494 (class 0 OID 18953)
-- Dependencies: 249
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfil (ide_perf, ide_rol, nombre_perf, descripcion_perf, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
0	0	padmin	Perfil del administrador - Acceso a todas las opciones (pantallas)	admin	2025-10-02 13:58:00	\N	\N
1	1	pbodega	Perfil del Encargado de Bodega	admin	2025-10-06 17:30:00	\N	\N
2	2	pinventario	Perfil del Admin del Inventario	admin	2025-10-06 17:31:00	\N	\N
3	3	pseguridad	Perfil de Seguridad - Auditorias	admin	2025-10-06 17:33:00	\N	\N
4	4	prrhh	Perfil del Encargado de Recursos Humanos - Contrataciones y gestión de los trabajadores	admin	2025-10-06 17:33:00	\N	\N
5	5	pventas	Perfil del Encargado de las Ventas	admin	2025-10-06 17:34:00	\N	\N
\.


--
-- TOC entry 5496 (class 0 OID 18963)
-- Dependencies: 251
-- Data for Name: perfil_opciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfil_opciones (ide_perf_opci, ide_perf, ide_opci, listar, insertar, modificar, eliminar, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	1	1	si	si	si	si	admin	2025-10-06 17:36:00	\N	\N
2	1	2	si	si	si	si	admin	2025-10-06 17:37:00	\N	\N
3	2	5	si	si	si	si	admin	2025-10-06 17:38:00	\N	\N
4	2	6	si	si	si	si	admin	2025-10-06 17:40:00	\N	\N
5	2	7	si	si	si	si	admin	2025-10-06 17:40:00	\N	\N
6	2	8	si	si	si	si	admin	2025-10-06 17:40:00	\N	\N
7	3	11	si	si	si	si	admin	2025-10-06 17:41:00	\N	\N
8	3	12	si	si	si	si	admin	2025-10-06 17:42:00	\N	\N
9	3	13	si	si	si	si	admin	2025-10-06 17:42:00	\N	\N
10	3	14	si	si	si	si	admin	2025-10-06 17:42:00	\N	\N
11	4	3	si	si	si	si	admin	2025-10-06 17:42:00	\N	\N
12	4	4	si	si	si	si	admin	2025-10-06 17:43:00	\N	\N
13	5	15	si	si	si	si	admin	2025-10-06 17:54:00	\N	\N
14	5	16	si	si	si	si	admin	2025-10-06 17:55:00	\N	\N
15	0	1	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
16	0	2	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
17	0	3	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
18	0	4	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
19	0	5	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
20	0	6	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
21	0	7	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
22	0	8	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
24	0	10	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
25	0	11	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
26	0	12	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
27	0	13	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
28	0	14	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
29	0	15	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
30	0	16	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
31	0	17	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
32	0	18	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
33	0	19	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
34	0	20	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
35	0	21	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
36	0	22	si	si	si	si	admin	2025-10-24 22:14:00	\N	\N
38	1	17	si	si	si	si	admin	2025-10-24 22:16:00	\N	\N
39	4	18	si	si	si	si	admin	2025-10-24 22:16:00	\N	\N
40	2	19	si	si	si	si	admin	2025-10-24 22:16:00	\N	\N
41	3	20	si	si	si	si	admin	2025-10-24 22:16:00	\N	\N
42	5	21	si	si	si	si	admin	2025-10-24 22:26:00	\N	\N
23	0	9	si	si	si	si	admin	2025-10-22 18:40:00	\N	\N
\.


--
-- TOC entry 5498 (class 0 OID 18983)
-- Dependencies: 253
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto (ide_prod, ide_cate, ide_marc, codigo_barra_prod, nombre_prod, precio_compra_prod, precio_venta_prod, iva_prod, dcto_promo_prod, dcto_caduc_prod, precio_final_prod, stock_prod, disponible_prod, estado_prod, descripcion_prod, usua_ingre, fecha_ingre, usua_actua, fecha_actua, url_img_prod) FROM stdin;
1	1	1	ACE-0123456789	shaolin soccer	0.50	1.00	0.10	0.00	0.00	1.00	0	no	inactivo	una gran pelicula	jsanchez	2025-11-22 17:16:37.868767	\N	\N	https://i.ibb.co/kgxMjrNS/img-1.jpg
\.


--
-- TOC entry 5500 (class 0 OID 19023)
-- Dependencies: 255
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedor (ide_prov, ide_empr, cedula_prov, fecha_nacimiento_prov, edad_prov, telefono_prov, email_prov, primer_nombre_prov, apellido_paterno_prov, segundo_nombre_prov, apellido_materno_prov, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	3	0734678554	1990-01-01	35	0956763465	jose@gmail.com	jose	plata	jeremy	arevalo	cvelez	2025-11-22 16:47:25.191018	\N	\N
2	3	0745632332	2003-01-02	21	0956479284	gallegos@gmail.com	carlos	gallegos	juan	orozco	cvelez	2025-11-22 16:49:17.467545	\N	\N
\.


--
-- TOC entry 5502 (class 0 OID 19038)
-- Dependencies: 257
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (ide_rol, nombre_rol, descripcion_rol, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
1	bodega	Rol del encargado de bodega	admin	2025-10-02 13:48:00	\N	\N
2	inventario	Rol del encargado del inventario	admin	2025-10-02 13:48:00	\N	\N
3	seguridad	Rol del encargado de seguridad y auditores	admin	2025-10-02 13:49:00	\N	\N
4	rrhh	Rol del encargado de talento humano	admin	2025-10-02 13:49:00	\N	\N
5	ventas	Rol de los vendedores	admin	2025-10-02 13:51:00	\N	\N
0	administracion	Rol del administrador total	admin	2025-10-02 13:53:00	\N	\N
\.


--
-- TOC entry 5504 (class 0 OID 19047)
-- Dependencies: 259
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venta (ide_vent, ide_empl, ide_clie, num_factura_vent, fecha_vent, cantidad_vent, sub_total_vent, total_vent, dcto_vent, estado_vent, usua_ingre, fecha_ingre, usua_actua, fecha_actua) FROM stdin;
\.


--
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 220
-- Name: acceso_usuario_ide_acce_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acceso_usuario_ide_acce_seq', 1, false);


--
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoria_ide_cate_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_ide_cate_seq', 1, true);


--
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 224
-- Name: cliente_ide_clie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_ide_clie_seq', 1, false);


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 226
-- Name: cuenta_ide_cuen_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_ide_cuen_seq', 5, true);


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 228
-- Name: detalle_entrega_ide_deta_entr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_entrega_ide_deta_entr_seq', 1, true);


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 230
-- Name: detalle_pedido_ide_deta_pedi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_pedido_ide_deta_pedi_seq', 1, true);


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 232
-- Name: detalle_venta_ide_deta_vent_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_venta_ide_deta_vent_seq', 1, false);


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 234
-- Name: empleado_ide_empl_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_ide_empl_seq', 5, true);


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 236
-- Name: empresa_ide_empr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_ide_empr_seq', 8, true);


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_precios_ide_empr_prod_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_precios_ide_empr_prod_seq', 1, true);


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 240
-- Name: entrega_ide_entr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entrega_ide_entr_seq', 1, true);


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 242
-- Name: lote_ide_lote_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lote_ide_lote_seq', 1, false);


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 244
-- Name: marca_ide_marc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marca_ide_marc_seq', 1, true);


--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 246
-- Name: opciones_ide_opci_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opciones_ide_opci_seq', 22, true);


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 248
-- Name: pedido_ide_pedi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_ide_pedi_seq', 1, true);


--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 250
-- Name: perfil_ide_perf_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_ide_perf_seq', 5, true);


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 252
-- Name: perfil_opciones_ide_perf_opci_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfil_opciones_ide_perf_opci_seq', 42, true);


--
-- TOC entry 5549 (class 0 OID 0)
-- Dependencies: 254
-- Name: producto_ide_prod_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_ide_prod_seq', 13, true);


--
-- TOC entry 5550 (class 0 OID 0)
-- Dependencies: 256
-- Name: proveedor_ide_prov_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedor_ide_prov_seq', 2, true);


--
-- TOC entry 5551 (class 0 OID 0)
-- Dependencies: 258
-- Name: rol_ide_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_ide_rol_seq', 5, true);


--
-- TOC entry 5552 (class 0 OID 0)
-- Dependencies: 260
-- Name: venta_ide_vent_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_ide_vent_seq', 1, false);


--
-- TOC entry 5240 (class 2606 OID 19093)
-- Name: acceso_usuario acceso_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acceso_usuario
    ADD CONSTRAINT acceso_usuario_pkey PRIMARY KEY (ide_acce);


--
-- TOC entry 5242 (class 2606 OID 19095)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (ide_cate);


--
-- TOC entry 5244 (class 2606 OID 19097)
-- Name: cliente cliente_cedula_clie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_cedula_clie_key UNIQUE (cedula_clie);


--
-- TOC entry 5246 (class 2606 OID 19099)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (ide_clie);


--
-- TOC entry 5248 (class 2606 OID 19101)
-- Name: cuenta cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (ide_cuen);


--
-- TOC entry 5250 (class 2606 OID 19103)
-- Name: cuenta cuenta_usuario_cuen_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_usuario_cuen_key UNIQUE (usuario_cuen);


--
-- TOC entry 5252 (class 2606 OID 19105)
-- Name: detalle_entrega detalle_entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_entrega
    ADD CONSTRAINT detalle_entrega_pkey PRIMARY KEY (ide_deta_entr);


--
-- TOC entry 5254 (class 2606 OID 19107)
-- Name: detalle_pedido detalle_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (ide_deta_pedi);


--
-- TOC entry 5256 (class 2606 OID 19109)
-- Name: detalle_venta detalle_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (ide_deta_vent);


--
-- TOC entry 5258 (class 2606 OID 19111)
-- Name: empleado empleado_cedula_empl_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_cedula_empl_key UNIQUE (cedula_empl);


--
-- TOC entry 5260 (class 2606 OID 19113)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (ide_empl);


--
-- TOC entry 5262 (class 2606 OID 19115)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (ide_empr);


--
-- TOC entry 5264 (class 2606 OID 19117)
-- Name: empresa_precios empresa_precios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_precios
    ADD CONSTRAINT empresa_precios_pkey PRIMARY KEY (ide_empr_prod);


--
-- TOC entry 5266 (class 2606 OID 19119)
-- Name: entrega entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_pkey PRIMARY KEY (ide_entr);


--
-- TOC entry 5268 (class 2606 OID 19121)
-- Name: lote lote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote
    ADD CONSTRAINT lote_pkey PRIMARY KEY (ide_lote);


--
-- TOC entry 5270 (class 2606 OID 19123)
-- Name: marca marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (ide_marc);


--
-- TOC entry 5272 (class 2606 OID 19125)
-- Name: opciones opciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opciones
    ADD CONSTRAINT opciones_pkey PRIMARY KEY (ide_opci);


--
-- TOC entry 5274 (class 2606 OID 19127)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (ide_pedi);


--
-- TOC entry 5278 (class 2606 OID 19129)
-- Name: perfil_opciones perfil_opciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_opciones
    ADD CONSTRAINT perfil_opciones_pkey PRIMARY KEY (ide_perf_opci);


--
-- TOC entry 5276 (class 2606 OID 19131)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (ide_perf);


--
-- TOC entry 5280 (class 2606 OID 19133)
-- Name: producto producto_codigo_barra_prod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_codigo_barra_prod_key UNIQUE (codigo_barra_prod);


--
-- TOC entry 5282 (class 2606 OID 19135)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (ide_prod);


--
-- TOC entry 5284 (class 2606 OID 19137)
-- Name: proveedor proveedor_cedula_prov_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_cedula_prov_key UNIQUE (cedula_prov);


--
-- TOC entry 5286 (class 2606 OID 19139)
-- Name: proveedor proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (ide_prov);


--
-- TOC entry 5288 (class 2606 OID 19141)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (ide_rol);


--
-- TOC entry 5290 (class 2606 OID 19143)
-- Name: venta venta_num_factura_vent_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_num_factura_vent_key UNIQUE (num_factura_vent);


--
-- TOC entry 5292 (class 2606 OID 19145)
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (ide_vent);


--
-- TOC entry 5293 (class 2606 OID 19146)
-- Name: acceso_usuario fk_acceso_usuario_cuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acceso_usuario
    ADD CONSTRAINT fk_acceso_usuario_cuenta FOREIGN KEY (ide_cuen) REFERENCES public.cuenta(ide_cuen) ON DELETE CASCADE;


--
-- TOC entry 5294 (class 2606 OID 19151)
-- Name: cuenta fk_cuenta_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT fk_cuenta_empleado FOREIGN KEY (ide_empl) REFERENCES public.empleado(ide_empl) ON DELETE CASCADE;


--
-- TOC entry 5295 (class 2606 OID 19156)
-- Name: cuenta fk_cuenta_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT fk_cuenta_perfil FOREIGN KEY (ide_perf) REFERENCES public.perfil(ide_perf) ON DELETE CASCADE;


--
-- TOC entry 5296 (class 2606 OID 19161)
-- Name: detalle_entrega fk_detalle_entrega_entrega; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_entrega
    ADD CONSTRAINT fk_detalle_entrega_entrega FOREIGN KEY (ide_entr) REFERENCES public.entrega(ide_entr) ON DELETE CASCADE;


--
-- TOC entry 5297 (class 2606 OID 19166)
-- Name: detalle_entrega fk_detalle_entrega_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_entrega
    ADD CONSTRAINT fk_detalle_entrega_producto FOREIGN KEY (ide_prod) REFERENCES public.producto(ide_prod) ON DELETE CASCADE;


--
-- TOC entry 5298 (class 2606 OID 19171)
-- Name: detalle_pedido fk_detalle_pedido_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (ide_pedi) REFERENCES public.pedido(ide_pedi) ON DELETE CASCADE;


--
-- TOC entry 5299 (class 2606 OID 19176)
-- Name: detalle_pedido fk_detalle_pedido_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (ide_prod) REFERENCES public.producto(ide_prod) ON DELETE CASCADE;


--
-- TOC entry 5300 (class 2606 OID 19181)
-- Name: detalle_venta fk_detalle_venta_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_producto FOREIGN KEY (ide_prod) REFERENCES public.producto(ide_prod) ON DELETE CASCADE;


--
-- TOC entry 5301 (class 2606 OID 19186)
-- Name: detalle_venta fk_detalle_venta_venta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_detalle_venta_venta FOREIGN KEY (ide_vent) REFERENCES public.venta(ide_vent) ON DELETE CASCADE;


--
-- TOC entry 5302 (class 2606 OID 19191)
-- Name: empleado fk_empleado_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT fk_empleado_rol FOREIGN KEY (ide_rol) REFERENCES public.rol(ide_rol) ON DELETE RESTRICT;


--
-- TOC entry 5303 (class 2606 OID 19196)
-- Name: empresa_precios fk_empresa_precios_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_precios
    ADD CONSTRAINT fk_empresa_precios_empresa FOREIGN KEY (ide_empr) REFERENCES public.empresa(ide_empr) ON DELETE CASCADE;


--
-- TOC entry 5304 (class 2606 OID 19201)
-- Name: empresa_precios fk_empresa_precios_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_precios
    ADD CONSTRAINT fk_empresa_precios_producto FOREIGN KEY (ide_prod) REFERENCES public.producto(ide_prod) ON DELETE CASCADE;


--
-- TOC entry 5305 (class 2606 OID 19206)
-- Name: entrega fk_entrega_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega_pedido FOREIGN KEY (ide_pedi) REFERENCES public.pedido(ide_pedi) ON DELETE CASCADE;


--
-- TOC entry 5306 (class 2606 OID 19211)
-- Name: entrega fk_entrega_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega_proveedor FOREIGN KEY (ide_prov) REFERENCES public.proveedor(ide_prov) ON DELETE RESTRICT;


--
-- TOC entry 5307 (class 2606 OID 19216)
-- Name: lote fk_lote_producto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lote
    ADD CONSTRAINT fk_lote_producto FOREIGN KEY (ide_prod) REFERENCES public.producto(ide_prod) ON DELETE CASCADE;


--
-- TOC entry 5308 (class 2606 OID 19221)
-- Name: pedido fk_pedido_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_empresa FOREIGN KEY (ide_empr) REFERENCES public.empresa(ide_empr) ON DELETE RESTRICT;


--
-- TOC entry 5310 (class 2606 OID 19226)
-- Name: perfil_opciones fk_perfil_opciones_opciones; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_opciones
    ADD CONSTRAINT fk_perfil_opciones_opciones FOREIGN KEY (ide_opci) REFERENCES public.opciones(ide_opci) ON DELETE CASCADE;


--
-- TOC entry 5311 (class 2606 OID 19231)
-- Name: perfil_opciones fk_perfil_opciones_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil_opciones
    ADD CONSTRAINT fk_perfil_opciones_perfil FOREIGN KEY (ide_perf) REFERENCES public.perfil(ide_perf) ON DELETE CASCADE;


--
-- TOC entry 5309 (class 2606 OID 19236)
-- Name: perfil fk_perfil_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT fk_perfil_rol FOREIGN KEY (ide_rol) REFERENCES public.rol(ide_rol) ON DELETE CASCADE;


--
-- TOC entry 5312 (class 2606 OID 19241)
-- Name: producto fk_producto_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (ide_cate) REFERENCES public.categoria(ide_cate) ON DELETE RESTRICT;


--
-- TOC entry 5313 (class 2606 OID 19246)
-- Name: producto fk_producto_marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_marca FOREIGN KEY (ide_marc) REFERENCES public.marca(ide_marc) ON DELETE RESTRICT;


--
-- TOC entry 5314 (class 2606 OID 19251)
-- Name: proveedor fk_proveedor_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT fk_proveedor_empresa FOREIGN KEY (ide_empr) REFERENCES public.empresa(ide_empr) ON DELETE RESTRICT;


--
-- TOC entry 5315 (class 2606 OID 19256)
-- Name: venta fk_venta_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (ide_clie) REFERENCES public.cliente(ide_clie) ON DELETE RESTRICT;


--
-- TOC entry 5316 (class 2606 OID 19261)
-- Name: venta fk_venta_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_venta_empleado FOREIGN KEY (ide_empl) REFERENCES public.empleado(ide_empl) ON DELETE RESTRICT;


-- Completed on 2025-12-10 22:09:48

--
-- PostgreSQL database dump complete
--

\unrestrict 1CsAdjhWRkR3uLm84lPCk58bJjQaRASdBqlCDXUApE4mmHsk5Djge8BUFM3gllj


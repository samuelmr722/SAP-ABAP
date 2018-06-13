FUNCTION-POOL zfi_datos_maestros.           "MESSAGE-ID ..

*Tablas para la consulta de los deudores
TABLES:
kna1, "- Datos generales
adrc, "- Datos de direccion
adr2, "- Datos de telefonos
adr6, "- Datos de correo
knb1, "- Datos de sociedad
knvv, "- Datos comerciales
knvp. "- Datos de interlocutores


*...Tipos de tablas
TYPES:
BEGIN OF g_ty_kna1,
kunnr TYPE kunnr , " Cliente
land1 TYPE land1 , " País
name1 TYPE name1 , " Nombre
name2 TYPE name2 , " Nombre 2
ort01 TYPE ort01 , " Población
*pstlz TYPE pstlz , " Código postal
regio TYPE regio , " Región
sortl TYPE sortl , " Conc.búsq.
*stras TYPE stras , " Calle
*telf1 TYPE telf1 , " Teléfono 1
*telfx TYPE telfx , " Nº telefax
*xcpdk TYPE xcpdk , " Cuenta CPD
adrnr TYPE adrnr , " Dirección
*mcod1 TYPE mcod1 , " Nombre
*mcod2 TYPE mcod2 , " Nombre 2
*mcod3 TYPE mcod3 , " Población
anred TYPE anred , " Tratamiento
aufsd TYPE aufsd , " Bloqueo central de pedidos
bahne TYPE bahne , " Latitud
bahns TYPE bahns , " Longitud
*bbbnr TYPE bbbnr , " Núm.ubicación int.1
*bbsnr TYPE bbsnr , " Núm.ubicación int.2
*begru TYPE begru , " Grupo autorizaciones
brsch TYPE brsch , " Ramo
*bubkz TYPE bubkz , " Dígito de control
*datlt TYPE datlt , " Transmisión de datos
erdat TYPE erdat , " Creado el
ernam TYPE ernam , " Creado por
*exabl TYPE exabl , " Puestos de descarga
faksd TYPE faksd_x , " Bloqueo central de factura
*fiskn TYPE fiskn , " Domicilio fiscal
*knazk TYPE knazk , " Horarios de trabajo
*knrza TYPE knrza , " Pagador alternativo
*konzs TYPE konzs , " Clave de grupo
ktokd TYPE ktokd , " Grupo de cuentas
kukla TYPE kukla , " Estrato cliente
lifnr TYPE lifnr , " Acreedor
lifsd TYPE lifsd_x , " Bloqueo central de entrega
locco TYPE locco , " Fecha Exp Doc
loevm TYPE loevm , " Petición de borrado central
name3 TYPE name3_gp , " Nombre 3
name4 TYPE name4_gp , " Nombre 4
niels TYPE niels , " Estado Cliente
ort02 TYPE ort02 , " Distrito
*pfach TYPE pfach , " Apartado
*pstl2 TYPE pstl2 , " CP del apartado
*counc TYPE counc , " Código de condado
*cityc TYPE cityc , " Código municipal
*rpmkr TYPE rpmkr , " Mercado regional
sperr TYPE sperr , " Bloqueo central de contabilización
*spras TYPE spras , " Clave de idioma
stcd1 TYPE stcd1 , " Nº ident.fis.1
*stcd2 TYPE stcd2 , " Nº ident.fis.2
*stkza TYPE stkza , " Recargo equivalencia
*stkzu TYPE stkzu , " Sujeto a IVA
*telbx TYPE telbx , " Número de telebox
*telf2 TYPE telf2 , " Teléfono 2
*teltx TYPE teltx , " Número de teletex
*telx1 TYPE telx1 , " Número de télex
lzone TYPE lzone , " Zona de transporte
*xzemp TYPE xzemp , " Pagador en documento
*vbund TYPE vbund , " Sociedad GL asociada
*stceg TYPE stceg , " N.I.F. comunitario
*dear1 TYPE dear1 , " Competencia
*dear2 TYPE dear2 , " Interlocutor ventas
*dear3 TYPE dear3 , " Interesado
*dear4 TYPE dear4 , " Clte.ref.surtido
*dear5 TYPE dear5 , " Solicitante por def.
*gform TYPE gform , " Status jurídico
*bran1 TYPE bran1 , " Código de ramo 1
*bran2 TYPE bran2 , " Código ramo 2
*bran3 TYPE bran3 , " Código ramo 3
*bran4 TYPE bran4 , " Código ramo 4
*bran5 TYPE bran5 , " Código ramo 5
*ekont TYPE ekont , " Primer contacto
*umsat TYPE umsat , " Vol.neg.anual
*umjah TYPE umjah , " Año volumen negocios
*uwaer TYPE uwaer , " Mon.volumen negocios
*jmzah TYPE jmzah , " Empleados
*jmjah TYPE jmjah , " Año empleados
*katr1 TYPE katr1 , " Atributo 1
*katr2 TYPE katr2 , " Atributo 2
*katr3 TYPE katr3 , " Atributo 3
*katr4 TYPE katr4 , " Atributo 4
*katr5 TYPE katr5 , " Atributo 5
*katr6 TYPE katr6 , " Atributo 6
*katr7 TYPE katr7 , " Atributo 7
*katr8 TYPE katr8 , " Atributo 8
*katr9 TYPE katr9 , " Atributo 9
*katr10 TYPE katr10 , " Atributo 10
stkzn TYPE stkzn , " Persona física
*umsa1 TYPE umsa1 , " Vol.neg.anual
*txjcd TYPE txjcd , " Domicilio fiscal
*periv TYPE periv , " Variante ejercicio
*abrvw TYPE abrvw , " Utilización
*inspbydebi TYPE inspbydebi , " Por parte cliente
*inspatdebi TYPE inspatdebi , " Tras entrega
*ktocd TYPE ktocd , " Ref.Grupo de cuentas
*pfort TYPE pfort , " Población apartado
*werks TYPE werks , " Centro
*dtams TYPE dtams , " Clave de notif.ISD
*dtaws TYPE dtaws , " Clave instrucción
*duefl TYPE duefl , " Status transf.datos a release siguiente
*hzuor TYPE hzuor , " Asignación jerarquía
*sperz TYPE sperz , " Bloqueo pago
*etikg TYPE etikg , " Etiquet.gr.clientes
*civve TYPE civve , " Utilización civil
*milve TYPE milve , " Utilización militar
*kdkg1 TYPE kdkg1 , " Grupo condiciones 1
*kdkg2 TYPE kdkg2 , " Grupo condiciones 2
*kdkg3 TYPE kdkg3 , " Grupo condiciones 3
*kdkg4 TYPE kdkg4 , " Grupo condiciones 4
*kdkg5 TYPE kdkg5 , " Grupo condiciones 5
*xknza TYPE xknza , " Ctas.p.pagador alt.
fityp TYPE fityp , " Clase de impuesto
stcdt TYPE j_1atoid , " Tipo NIF
*stcd3 TYPE stcd3 , " NIF 3
*stcd4 TYPE stcd4 , " NIF 4
*stcd5 TYPE stcd5 , " Número fiscal 5
*xicms TYPE xicms , " Exento de ICMS
*xxipi TYPE xxipi , " Exento de IPI
*xsubt TYPE xsubt , " Grupo SubTrib
*cfopc TYPE cfopc , " Categ.CFOP deudor
*txlw1 TYPE txlw1 , " Ley ICMS
*txlw2 TYPE txlw2 , " Ley IPI
*ccc01 TYPE ccc01 , " Armas químic./biol.
*ccc02 TYPE ccc02 , " No prolif.tecn.nucl.
*ccc03 TYPE ccc03 , " Seguridad nacional
*ccc04 TYPE ccc04 , " Tecnología misiles
cassd TYPE cassd_x , " Bloqueo de contacto central
*knurl TYPE knurl , " URL
*j_1kfrepre TYPE j_1kfrepre , " Nombre del representante
*j_1kftbus TYPE j_1kftbus , " Tipo de operación
*j_1kftind TYPE j_1kftind , " Tipo de industria
*confs TYPE confs , " Status confirmación
*updat TYPE updat , " Fecha confirmación
*uptim TYPE uptim , " Hora de confirmación
nodel TYPE nodel , " Bloq.borrado central
*dear6 TYPE dear6 , " Consumidor final
*suframa TYPE suframa , " Suframa Code
*rg TYPE rg , " RG Number
*exp TYPE exp , " Issued by
*uf TYPE uf , " State
*rgdate TYPE rgdate , " RG Issue Date
*ric TYPE ric , " RIC Number
*rne TYPE rne , " Foreign National Registration
*rnedate TYPE rnedate , " RNE Issue Date
*cnae TYPE cnae , " CNAE
*legalnat TYPE legalnat , " Legal Nature
*crtn TYPE crtn , " CRT Number
*icmstaxpay TYPE icmstaxpay , " ICMS Taxpayer
*indtyp TYPE indtyp , " Industry Main Type
*tdt TYPE tdt , " Tax Declaration Type
*comsize TYPE comsize , " Company Size
*decregpc TYPE decregpc , " Declaration Regimen for PIS/COFINS
*/vso/r_palhgt TYPE /vso/r_palhgt , " Altura emb.máxima
*/vso/r_pal_ul TYPE /vso/r_pal_ul , " Un.longitud mat.emb.
*/vso/r_pk_mat TYPE /vso/r_pk_mat , " Embje.cliente único
*/vso/r_matpal TYPE /vso/r_matpal , " Mat.embalaje cliente
*/vso/r_i_no_lyr TYPE /vso/r_i_no_lyr , " Ctd.cpa.ent.pal.int
*/vso/r_one_mat TYPE /vso/r_one_mat , " Embalaje mat.único
*/vso/r_one_sort TYPE /vso/r_one_sort , " Embje.tp.bulto único
*/vso/r_uld_side TYPE /vso/r_uld_side , " Preferencia lateral
*/vso/r_load_pref TYPE /vso/r_load_pref , " Preferencia Ant/Post
*/vso/r_dpoint TYPE /vso/r_dpoint , " Pto.descga.colect.
*alc TYPE alc , " Agency Location Code
*pmt_office TYPE pmt_office , " Payment Office
*psofg TYPE psofg , " Equipo responsable
*psois TYPE psois , " Proc.previo cta.ter.
*pson1 TYPE pson1 , " Nombre
*pson2 TYPE pson2 , " Nombre 2
*pson3 TYPE pson3 , " Nombre 3
*psovn TYPE psovn , " Nombre
*psotl TYPE psotl , " Títulos
*psohs TYPE psohs , " Nº (edificio)
*psost TYPE psost , " Calle
*psoo1 TYPE psoo1 , " Descripción
*psoo2 TYPE psoo2 , " Descripción
*psoo3 TYPE psoo3 , " Descripción
*psoo4 TYPE psoo4 , " Descripción
*psoo5 TYPE psoo5 , " Descripción
*j_3astcu TYPE j_3astcu , " ID clte.sist.contr.
*j_3adccu TYPE j_3adccu , " Centro distribución
END OF g_ty_kna1,

BEGIN OF g_ty_adrc,
addrnumber TYPE ad_addrnum , " Nº dirección
*date_from TYPE date_from , " de
*nation TYPE nation , " Versión dirección
*date_to TYPE date_to , " a
*title TYPE title , " Tratamiento
*name1 TYPE name1 , " Nombre
*name2 TYPE name2 , " Nombre 2
*name3 TYPE name3 , " Nombre 3
*name4 TYPE name4 , " Nombre 4
*name_text TYPE name_text , " Nombre convertido
*name_co TYPE name_co , " c/o
*city1 TYPE city1 , " Población
*city2 TYPE city2 , " Barrio
*city_code TYPE city_code , " Nº de población
*cityp_code TYPE cityp_code , " Distrito
*home_city TYPE home_city , " Residencia alt.
*cityh_code TYPE cityh_code , " Nº de población
*chckstatus TYPE chckstatus , " St.verif./fich.pobl.
*regiogroup TYPE regiogroup , " Agrup.estruc.reg.
*post_code1 TYPE post_code1 , " Código postal
*post_code2 TYPE post_code2 , " CP apartado
*post_code3 TYPE post_code3 , " Cód.postal empresa
*pcode1_ext TYPE pcode1_ext , " Ampl.código postal
*pcode2_ext TYPE pcode2_ext , " Ampl.código postal
*pcode3_ext TYPE pcode3_ext , " Ampl.código postal
*po_box TYPE po_box , " Apartado
*dont_use_p TYPE dont_use_p , " Destinatario descon.
*po_box_num TYPE po_box_num , " Apartado sin nº
*po_box_loc TYPE po_box_loc , " Población apartado
*city_code2 TYPE city_code2 , " Nº de población
*po_box_reg TYPE po_box_reg , " Región del apartado
*po_box_cty TYPE po_box_cty , " País rel.apartado
*postalarea TYPE postalarea , " Distrito postal
*transpzone TYPE transpzone , " Zona de transporte
street TYPE ad_street , " Calle
*dont_use_s TYPE dont_use_s , " Destinatario descon.
*streetcode TYPE streetcode , " Nº de calle
*streetabbr TYPE streetabbr , " Abreviación calle
*house_num1 TYPE house_num1 , " Nº (edificio)
*house_num2 TYPE house_num2 , " Apéndice
*house_num3 TYPE house_num3 , " Ámbito número casa
str_suppl1 TYPE ad_strspp1 , " Calle 2
str_suppl2 TYPE ad_strspp2 , " Calle 3
str_suppl3 TYPE ad_strspp3 , " Calle 4
location TYPE ad_lctn , " Calle 5
*building TYPE building , " Sigla del edificio
*floor TYPE floor , " Piso
*roomnumber TYPE roomnumber , " Nº habitación
*country TYPE country , " Clave de país
*langu TYPE langu , " Clave de idioma
*region TYPE region , " Región
*addr_group TYPE addr_group , " Grupo direcciones
*flaggroups TYPE flaggroups , " Indicador: Existen otras asignaciones para gr.direcciones
*pers_addr TYPE pers_addr , " Dirección personal
*sort1 TYPE sort1 , " Concepto búsqueda 1
*sort2 TYPE sort2 , " Concepto búsqueda 2
*sort_phn TYPE sort_phn , " Clasif.fonética
*deflt_comm TYPE deflt_comm , " Forma comunicación
*tel_number TYPE tel_number , " Teléfono
*tel_extens TYPE tel_extens , " Extensión
*fax_number TYPE fax_number , " Fax
*fax_extens TYPE fax_extens , " Extensión
*flagcomm2 TYPE flagcomm2 , " Teléfono...
*flagcomm3 TYPE flagcomm3 , " Telefax...
*flagcomm4 TYPE flagcomm4 , " Teletex
*flagcomm5 TYPE flagcomm5 , " Télex
*flagcomm6 TYPE flagcomm6 , " Corr.elect.actualiz.
*flagcomm7 TYPE flagcomm7 , " R/Mail
*flagcomm8 TYPE flagcomm8 , " X.400
*flagcomm9 TYPE flagcomm9 , " RFC
*flagcomm10 TYPE flagcomm10 , " Impresora
*flagcomm11 TYPE flagcomm11 , " SSF
*flagcomm12 TYPE flagcomm12 , " URI/FTP
*flagcomm13 TYPE flagcomm13 , " Pager
*addrorigin TYPE addrorigin , " Fuente dirección
*mc_name1 TYPE mc_name1 , " Nombre de la empresa
*mc_city1 TYPE mc_city1 , " Población
*mc_street TYPE mc_street , " Calle
*extension1 TYPE extension1 , " Línea transm.datos
*extension2 TYPE extension2 , " Telebox
*time_zone TYPE time_zone , " Huso horario
*taxjurcode TYPE taxjurcode , " Domicilio fiscal
*address_id TYPE address_id , " ID dirección
*langu_crea TYPE langu_crea , " Idioma de creación
*adrc_uuid TYPE adrc_uuid , " UUID dirección
*uuid_belated TYPE uuid_belated , " UUID creado posteriormente
*id_category TYPE id_category , " Categoría ID dir.
*adrc_err_status TYPE adrc_err_status , " Status de error
*po_box_lobby TYPE po_box_lobby , " Estación ap.correos
*deli_serv_type TYPE deli_serv_type , " Clase servicio entrega
*deli_serv_number TYPE deli_serv_number , " Número del servicio de entrega
*county_code TYPE county_code , " Código de distrito
*county TYPE county , " Distrito
*township_code TYPE township_code , " Código municipal
*township TYPE township , " Ciudad
*mc_county TYPE mc_county , " Distrito
*mc_township TYPE mc_township , " Ciudad
*xpcpt TYPE xpcpt , " Conclusión de objetivo de util.
END OF g_ty_adrc,

BEGIN OF g_ty_adr2,
addrnumber TYPE ad_addrnum , " Nº dirección
*persnumber TYPE persnumber , " Número de persona
*date_from TYPE date_from , " de
consnumber TYPE ad_consnum , " Número actual
*country TYPE country , " País
*flgdefault TYPE flgdefault , " Nº estándar
*flg_nouse TYPE flg_nouse , " Sin utilización número comunicación
*home_flag TYPE home_flag , " Direc.país origen
tel_number TYPE ad_tlnmbr1 , " Teléfono
*tel_extens TYPE tel_extens , " Extensión
*telnr_long TYPE telnr_long , " Nº teléfono
*telnr_call TYPE telnr_call , " Nº persona que llama
*dft_receiv TYPE dft_receiv , " SMS act.
*r3_user TYPE r3_user , " Tel.móvil
*valid_from TYPE valid_from , " Válido de
*valid_to TYPE valid_to , " Validez a
END OF g_ty_adr2,

BEGIN OF g_ty_adr6,
addrnumber TYPE ad_addrnum , " Nº dirección
*persnumber TYPE persnumber , " Número de persona
*date_from TYPE date_from , " de
consnumber TYPE ad_consnum , " Número actual
*flgdefault TYPE flgdefault , " Direc.por defecto
*flg_nouse TYPE flg_nouse , " Sin utilización número comunicación
*home_flag TYPE home_flag , " Direc.país origen
smtp_addr TYPE ad_smtpadr , " Dir.cor.elec.
*smtp_srch TYPE smtp_srch , " Dir.correo electrónico
*dft_receiv TYPE dft_receiv , " Receptor estándar
*r3_user TYPE r3_user , " Ind.: Conexión R/3
*encode TYPE encode , " Codificación
*tnef TYPE tnef , " TNEF
*valid_from TYPE valid_from , " Válido de
*valid_to TYPE valid_to , " Validez a
END OF g_ty_adr6,

BEGIN OF g_ty_knb1,
kunnr TYPE kunnr , " Cliente
bukrs TYPE bukrs , " Sociedad
pernr TYPE pernr_d , " Número de personal
erdat TYPE erdat , " Creado el
ernam TYPE ernam , " Creado por
sperr TYPE sperr , " Bloqueo contab. para sociedad
loevm TYPE loevm , " Petición de borrado p.sociedad
*zuawa TYPE zuawa , " Clave clasificación
*busab TYPE busab , " Responsable
akont TYPE akont , " Cuenta asociada
*begru TYPE begru , " Grupo autorizaciones
*knrze TYPE knrze , " Central
*knrzb TYPE knrzb , " Pagador alternativo
*zamim TYPE zamim , " Deudor (con PC)
*zamiv TYPE zamiv , " Comercial
*zamir TYPE zamir , " Dpto.jurídico
*zamib TYPE zamib , " Contab.financ.
*zamio TYPE zamio , " Deudor (sin PC)
zwels TYPE dzwels , " Vías de pago
*xverr TYPE xverr , " Compensar c/acreedor
zahls TYPE dzahls , " Bloqueo de pago
zterm TYPE dzterm , " Condiciones de pago
*wakon TYPE wakon , " Cond. gastos Efc.
*vzskz TYPE vzskz , " Indicador intereses
*zindt TYPE zindt , " Fe.clave últ.cálc.intereses
*zinrt TYPE zinrt , " Ritmo cálc.intereses
*eikto TYPE eikto , " Cuenta en el deudor
*zsabe TYPE zsabe , " Responsable deudor
*kverm TYPE kverm , " Nota interior cuenta
fdgrv TYPE fdgrv , " Grupo de tesorería
*vrbkz TYPE vrbkz , " Nº de la entidad
*vlibb TYPE vlibb , " Valor asegurado
*vrszl TYPE vrszl , " Meses de cobertura
*vrspr TYPE vrspr , " Participación
*vrsnr TYPE vrsnr , " Número de contrato
*verdt TYPE verdt , " Validez a
*perkz TYPE perkz , " Variante fact.col.
*xdezv TYPE xdezv , " Trat. no centraliz.
*xausz TYPE xausz , " Extracto de cuenta
*webtr TYPE webtr , " Límite efectos
*remit TYPE remit , " RecPago más próximo
*datlz TYPE datlz , " Fecha CPU últ.cálculo ints.
xzver TYPE xzver , " Anotar historial
*togru TYPE togru , " Grupo tolerancia
*kultg TYPE kultg , " Días hasta cobro
*hbkid TYPE hbkid , " Banco propio
*xpore TYPE xpore , " Pago único
*blnkz TYPE blnkz , " In. de preferencia
altkn TYPE altkn , " Fecha Nacmnto
*zgrup TYPE zgrup , " Clave agrupación
*urlid TYPE urlid , " Acuerdo vacaciones
*mgrup TYPE mgrup , " Clave agrupación
*lockb TYPE lockb , " Lockbox
*uzawe TYPE uzawe , " Supl.vía pago
*ekvbd TYPE ekvbd , " Central de compras
*sregl TYPE sregl , " Regla de selección
*xedip TYPE xedip , " Aviso pago por EDI
*frgrp TYPE frgrp , " Grupo de liberación
*vrsdg TYPE vrsdg , " Convers.orig.difer.
*tlfxs TYPE tlfxs , " Telefaz encargado
*intad TYPE intad , " Direc.Internet resp.
*xknzb TYPE xknzb , " Ctas.p.pagador alt.
*guzte TYPE guzte , " Cond.pago abono
*gricd TYPE gricd , " Actividad impto.IngB
*gridt TYPE gridt , " Clase distribución
*wbrsl TYPE wbrsl , " Amo acumulada
*confs TYPE confs , " Stat.confirm.p.soc.
*updat TYPE updat , " Fecha confirmación
*uptim TYPE uptim , " Hora de confirmación
*nodel TYPE nodel , " Bloq.borrado soc.
*tlfns TYPE tlfns , " Teléfono responsable
*cession_kz TYPE cession_kz , " Ind.cesión créditos
*avsnd TYPE avsnd , " Aviso por XML
*ad_hash TYPE ad_hash , " E-mail para aviso
*qland TYPE qland , " País de retención
ciiucode TYPE ciiucode , " Actividad económica pral.según cód.CIIU
*gmvkzd TYPE gmvkzd , " Deudor en ejecución
END OF g_ty_knb1,

BEGIN OF g_ty_knvv,
kunnr TYPE kunnr , " Cliente
vkorg TYPE vkorg , " Organización ventas
vtweg TYPE vtweg , " Canal distribución
spart TYPE spart , " Sector
ernam TYPE ernam , " Creado por
erdat TYPE erdat , " Creado el
*begru TYPE begru , " Grupo autorizaciones
*loevm TYPE loevm , " Petic.borrado p.área de ventas
*versg TYPE versg , " Grupo estad. cliente
aufsd TYPE aufsd , " Bloqueo de pedido p.área de ventas
kalks TYPE kalks , " Esquema de cliente
kdgrp TYPE kdgrp , " Mail Plan
bzirk TYPE bzirk , " Zona de ventas
konda TYPE konda , " Grupo de precios
pltyp TYPE pltyp , " Lista de precios
*awahr TYPE awahr , " Probabilidad pedido
*inco1 TYPE inco1 , " Incoterms
*inco2 TYPE inco2 , " Incoterms, parte 2
lifsd TYPE lifsd_v , " Bloqueo de entrega p.área de ventas
*autlf TYPE autlf , " Entrega completa
*antlf TYPE antlf , " Máx.entreg.parciales
*kztlf TYPE kztlf , " Entrega parcial/pos.
*kzazu TYPE kzazu , " Agrupamiento pedidos
*chspl TYPE chspl , " Partic.lotes permit.
lprio TYPE lprio , " Prioridad de entrega
eikto TYPE eikto , " Última Campaña
vsbed TYPE vsbed , " Condición expedición
faksd TYPE faksd_v , " Bloqueo factura p.área de ventas
mrnkz TYPE mrnkz , " Trat.post.factura
*perfk TYPE perfk , " Fechas facturación
*perrl TYPE perrl , " Fechas lista factura
*kvakz TYPE kvakz , " Presupuesto
*kvawt TYPE kvawt , " PresEstimCostesMáx
waers TYPE waers , " Moneda
*klabc TYPE klabc , " Clasificación ABC
ktgrd TYPE ktgrd , " Gr.imputación clte.
zterm TYPE dzterm , " Condiciones de pago
vwerk TYPE vwerk , " Centro suministrador
vkgrp TYPE vkgrp , " Grupo de vendedores
vkbur TYPE vkbur , " Oficina de ventas
*vsort TYPE vsort , " Propuesta posiciones
kvgr1 TYPE kvgr1 , " Estado Esténcil
kvgr2 TYPE kvgr2 , " Clasif. por Valor
*kvgr3 TYPE kvgr3 , " Grupo de clientes 3
*kvgr4 TYPE kvgr4 , " Grupo de clientes 4
*kvgr5 TYPE kvgr5 , " Grupo de clientes 5
*bokre TYPE bokre , " Rappel
*boidt TYPE boidt , " Índice de rappel
*kurst TYPE kurst , " Tipo de cotización
prfre TYPE prfre , " Determinación precio
*prat1 TYPE prat1 , " Atributo 1
*prat2 TYPE prat2 , " Atributo prod. 2
*prat3 TYPE prat3 , " Atributo producto 3
*prat4 TYPE prat4 , " Atributo producto 4
*prat5 TYPE prat5 , " Atributo producto 5
*prat6 TYPE prat6 , " Atributo producto 6
*prat7 TYPE prat7 , " Atributo producto 7
*prat8 TYPE prat8 , " Atr.producto 8
*prat9 TYPE prat9 , " Atributo producto 9
*prata TYPE prata , " Atributo producto 10
*kabss TYPE kabss , " Esquema de garantías
*kkber TYPE kkber , " Área ctrl.créditos
*cassd TYPE cassd , " Bloqueo de contacto p.área de ventas
*rdoff TYPE rdoff , " Desactivar redondeo
*agrel TYPE agrel , " Operación de agencia
*megru TYPE megru , " Grupo un.medida
*uebto TYPE uebto , " Tol.exc.suministro
*untto TYPE untto , " Toler.faltas sumin.
*uebtk TYPE uebtk , " Tol.ilimitada
*pvksm TYPE pvksm , " Esq.clte.prop.prod.
*podkz TYPE podkz , " Relevante ARE
*podtg TYPE podtg , " Vent.tiempo ARE
*blind TYPE blind , " Índice doc.activo
*carrier_notif TYPE carrier_notif , " Mensaje a transportista
*j_3ahsiz TYPE j_3ahsiz , " Campo X, sin uso
*j_3acats TYPE j_3acats , " Campo X, sin uso
*j_3amsar TYPE j_3amsar , " Este campo no se utiliza actualmente
*/bev1/emlgpfand TYPE /bev1/emlgpfand , " Depósito envases off
*/bev1/emlgforts TYPE /bev1/emlgforts , " Actualiz.env.off
*j_3agcid TYPE j_3agcid , " Ind.clte./proveedor
*j_3avascg TYPE j_3avascg , " SVA Grupo clientes
*j_3avakzp TYPE j_3avakzp , " Material de embalaje
*j_3avakzt TYPE j_3avakzt , " Material etiquetado
*j_3avakzs TYPE j_3avakzs , " Servicios esp.mat.
*j_3avakzg TYPE j_3avakzg , " Gener.posiciones
*j_3avakzm TYPE j_3avakzm , " Act.posición SVA
*j_3aoslm TYPE j_3aoslm , " Estrat.programación
*j_3agrsgy TYPE j_3agrsgy , " Estrat.agrupación
*j_3aresgy TYPE j_3aresgy , " Estrateg.liberación
*j_3akvgr6 TYPE j_3akvgr6 , " Grupo clientes 6
*j_3akvgr7 TYPE j_3akvgr7 , " Grupo clientes 7
*j_3akvgr8 TYPE j_3akvgr8 , " Grupo clientes 8
*j_3akvgr9 TYPE j_3akvgr9 , " Grupo clientes 9
*j_3akvgr10 TYPE j_3akvgr10 , " Grupo de clientes 10
*j_3asubs TYPE j_3asubs , " Sustitución desact.
*j_3adupk TYPE j_3adupk , " Sin clave duplicada
*/afs/msosr TYPE /afs/msosr , " Regla distr.PMT II
*/afs/sub_str_or TYPE /afs/sub_str_or , " Estrat.sustitución
*/afs/sub_str_ar TYPE /afs/sub_str_ar , " Estrat.sustitución
END OF g_ty_knvv,

BEGIN OF g_ty_knvp,
kunnr TYPE kunnr , " Cliente
vkorg TYPE vkorg , " Organización ventas
vtweg TYPE vtweg , " Canal distribución
spart TYPE spart , " Sector
parvw TYPE parvw , " Función interlocutor
*parza TYPE parza , " Contador interlocut.
kunn2 TYPE kunn2 , " Cliente
*lifnr TYPE lifnr , " Acreedor
pernr TYPE pernr_d , " Número de personal
*parnr TYPE parnr , " Persona de contacto
*knref TYPE knref , " Denom.interlocutor
*defpa TYPE defpa , " Interl. por defecto
END OF g_ty_knvp,

BEGIN OF g_ty_text,
"textos
kunnr TYPE kunnr , " Cliente
vkorg TYPE vkorg , " Organización ventas
vtweg TYPE vtweg , " Canal distribución
spart TYPE spart , " Sector
cupocredito(100) TYPE c , " Cupo credito
tipocartera(100) TYPE c , " Tipo cartera
seccion(100) TYPE c , " Seccion
END OF g_ty_text.

*BEGIN OF g_ty_final,
*"kna1,
*kunnr TYPE kunnr , " Cliente
*land1 TYPE land1 , " País
*name1 TYPE name1 , " Nombre
*name2 TYPE name2 , " Nombre 2
*ort01 TYPE ort01 , " Población
*regio TYPE regio , " Región
*sortl TYPE sortl , " Conc.búsq.
*adrnr TYPE adrnr , " Dirección
*anred TYPE anred , " Tratamiento
*aufsd_kna1 TYPE aufsd , " Bloqueo central de pedidos
*bahne TYPE bahne , " Latitud
*bahns TYPE bahns , " Longitud
*brsch TYPE brsch , " Ramo
*erdat_kna1 TYPE erdat , " Creado el
*ernam_kna1 TYPE ernam , " Creado por
*faksd_kna1 TYPE faksd_x , " Bloqueo central de factura
*ktokd TYPE ktokd , " Grupo de cuentas
*kukla TYPE kukla , " Estrato cliente
*lifnr TYPE lifnr , " Acreedor
*lifsd_kna1 TYPE lifsd_x , " Bloqueo central de entrega
*locco TYPE locco , " Fecha Exp Doc
*loevm_kna1 TYPE loevm , " Petición de borrado central
*niels TYPE niels , " Estado Cliente
*ort02 TYPE ort02 , " Distrito
*sperr_kna1 TYPE sperr , " Bloqueo central de contabilización
*stcd1 TYPE stcd1 , " Nº ident.fis.1
*lzone TYPE lzone , " Zona de transporte
*stkzn TYPE stkzn , " Persona física
*fityp TYPE fityp , " Clase de impuesto
*stcdt TYPE j_1atoid , " Tipo NIF
*cassd TYPE cassd_x , " Bloqueo de contacto central
*nodel TYPE nodel , " Bloq.borrado central
*"----------------------------------------------
*"adrc,
**addrnumber TYPE ad_addrnum , " Nº dirección
*street TYPE ad_street , " Calle
*str_suppl1 TYPE ad_strspp1 , " Calle 2
*str_suppl2 TYPE ad_strspp2 , " Calle 3
*str_suppl3 TYPE ad_strspp3 , " Calle 4
*location TYPE ad_lctn , " Calle 5
*"----------------------------------------------
*"adr2,
**addrnumber TYPE ad_addrnum , " Nº dirección
**consnumber TYPE ad_consnum , " Número actual
**tel_number TYPE ad_tlnmbr1 , " Teléfono
*tel_number1 TYPE ad_tlnmbr1 , " Teléfono
*tel_number2 TYPE ad_tlnmbr1 , " Teléfono
*"----------------------------------------------
*"adr6,
**addrnumber TYPE ad_addrnum , " Nº dirección
**consnumber TYPE ad_consnum , " Número actual
**smtp_addr TYPE ad_smtpadr , " Dir.cor.elec.
*smtp_addr1 TYPE ad_smtpadr , " Dir.cor.elec.
*smtp_addr2 TYPE ad_smtpadr , " Dir.cor.elec.
*"----------------------------------------------
*"knb1,
**kunnr TYPE kunnr , " Cliente
*bukrs TYPE bukrs , " Sociedad
*pernr TYPE pernr_d , " Número de personal
*erdat_knb1 TYPE erdat , " Creado el
*ernam_knb1 TYPE ernam , " Creado por
*sperr_knb1 TYPE sperr , " Bloqueo contab. para sociedad
*loevm_knb1 TYPE loevm , " Petición de borrado p.sociedad
*akont TYPE akont , " Cuenta asociada
*zwels TYPE dzwels , " Vías de pago
*zahls TYPE dzahls , " Bloqueo de pago
*zterm_knb1 TYPE dzterm , " Condiciones de pago
*fdgrv TYPE fdgrv , " Grupo de tesorería
*xzver TYPE xzver , " Anotar historial
*altkn TYPE altkn , " Fecha Nacmnto
*ciiucode TYPE ciiucode , " Actividad económica pral.según cód.CIIU
*"----------------------------------------------
*"knvv,
**kunnr TYPE kunnr , " Cliente
*vkorg TYPE vkorg , " Organización ventas
*vtweg TYPE vtweg , " Canal distribución
*spart TYPE spart , " Sector
*ernam_knvv TYPE ernam , " Creado por
*erdat_knvv TYPE erdat , " Creado el
*aufsd_knvv TYPE aufsd , " Bloqueo de pedido p.área de ventas
*kalks TYPE kalks , " Esquema de cliente
*kdgrp TYPE kdgrp , " Mail Plan
*bzirk TYPE bzirk , " Zona de ventas
*konda TYPE konda , " Grupo de precios
*pltyp TYPE pltyp , " Lista de precios
*lifsd_knvv TYPE lifsd_v , " Bloqueo de entrega p.área de ventas
*lprio TYPE lprio , " Prioridad de entrega
*eikto TYPE eikto , " Última Campaña
*vsbed TYPE vsbed , " Condición expedición
*faksd_knvv TYPE faksd_v , " Bloqueo factura p.área de ventas
*mrnkz TYPE mrnkz , " Trat.post.factura
*waers TYPE waers , " Moneda
*ktgrd TYPE ktgrd , " Gr.imputación clte.
*zterm_knvv TYPE dzterm , " Condiciones de pago
*vwerk TYPE vwerk , " Centro suministrador
*vkgrp TYPE vkgrp , " Grupo de vendedores
*vkbur TYPE vkbur , " Oficina de ventas
*kvgr1 TYPE kvgr1 , " Estado Esténcil
*kvgr2 TYPE kvgr2 , " Clasif. por Valor
*prfre TYPE prfre , " Determinación precio
*CupoCredito(100) TYPE C , " Cupo credito
*TipoCartera(100) TYPE C , " Tipo cartera
*Seccion(100) TYPE C , " Seccion
*"----------------------------------------------
*"knvp,
**kunnr TYPE kunnr , " Cliente
**vkorg TYPE vkorg , " Organización ventas
**vtweg TYPE vtweg , " Canal distribución
**spart TYPE spart , " Sector
**parvw TYPE parvw , " Función interlocutor
**kunn2 TYPE kunn2 , " Cliente
**pernr TYPE pernr_d , " Número de personal
*zc TYPE kunn2 , " Codeudor
*zd TYPE pernr_d , " DirectoraZona
*zr TYPE kunn2 , " Referente
*"----------------------------------------------
*END OF g_ty_final.

* INCLUDE LZFI_DATOS_MAESTROSD...            " Local class definition
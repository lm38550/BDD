---------------------- erasmus1 ------------------------

GRANT ALL
ON PRODUCTOR
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON SUCURSAL
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON CLIENTE
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON EMPLEADO
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON VINO
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON PIDE
TO erasmus2, erasmus3, erasmus4;
commit;

GRANT ALL
ON SUMINISTRO
TO erasmus2, erasmus3, erasmus4;
commit;

---------------------- erasmus2 ------------------------

GRANT ALL
ON PRODUCTOR
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON SUCURSAL
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON CLIENTE
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON EMPLEADO
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON VINO
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON PIDE
TO erasmus1, erasmus3, erasmus4;
commit;

GRANT ALL
ON SUMINISTRO
TO erasmus1, erasmus3, erasmus4;
commit;

---------------------- erasmus3 ------------------------

GRANT ALL
ON PRODUCTOR
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON SUCURSAL
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON CLIENTE
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON EMPLEADO
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON VINO
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON PIDE
TO erasmus1, erasmus2, erasmus4;
commit;

GRANT ALL
ON SUMINISTRO
TO erasmus1, erasmus2, erasmus4;
commit;

---------------------- erasmus4 ------------------------

GRANT ALL
ON PRODUCTOR
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON SUCURSAL
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON CLIENTE
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON EMPLEADO
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON VINO
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON PIDE
TO erasmus1, erasmus2, erasmus3;
commit;

GRANT ALL
ON SUMINISTRO
TO erasmus1, erasmus2, erasmus3;
commit;
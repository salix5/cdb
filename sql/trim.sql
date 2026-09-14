BEGIN TRANSACTION;
DELETE FROM datas WHERE id = 68811206;
DELETE FROM texts WHERE id = 68811206;
DELETE FROM datas WHERE id = 20240828;
DELETE FROM texts WHERE id = 20240828;
UPDATE datas SET (atk, def, level, race, attribute, scale, marker) = (0, 0, 0, 0, 0, 0, 0) WHERE (type & 0x1) = 0;
COMMIT;

ALTER TABLE datas ADD COLUMN color INTEGER GENERATED ALWAYS AS (
    CASE (type & 0x59f60d7)
        WHEN 0x4000 THEN 0x0
        WHEN 0x4011 THEN 0x0
        WHEN 0x11   THEN 0x1
        WHEN 0x1000011 THEN 0x2
        WHEN 0x81   THEN 0x3
        WHEN 0x1000081 THEN 0x4
        WHEN 0x41   THEN 0x5
        WHEN 0x1000041 THEN 0x6
        WHEN 0x2001 THEN 0x7
        WHEN 0x1002001 THEN 0x8
        WHEN 0x800001 THEN 0x9
        WHEN 0x1800001 THEN 0xa
        WHEN 0x4000001 THEN 0xb
        WHEN 0x2 THEN 0x10
        WHEN 0x10002 THEN 0x11
        WHEN 0x20002 THEN 0x12
        WHEN 0x40002 THEN 0x13
        WHEN 0x82 THEN 0x14
        WHEN 0x80002 THEN 0x15
        WHEN 0x4 THEN 0x20
        WHEN 0x20004 THEN 0x21
        WHEN 0x100004 THEN 0x22
        ELSE CASE
            WHEN (type & 0x21) = 0x21 THEN 0xc
            ELSE -1
        END
    END
) VIRTUAL;

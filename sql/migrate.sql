BEGIN TRANSACTION;
ALTER TABLE datas ADD COLUMN rule_code INTEGER DEFAULT 0;
UPDATE datas
SET rule_code = alias, alias = 0
WHERE alias != 0
    AND abs(id - alias) >= 20
    AND (type & 0x4000) = 0;
UPDATE datas SET rule_code = alias, alias = 0 WHERE id = 5405695;
UPDATE datas SET rule_code = 13331639 WHERE alias = 6218704;

ALTER TABLE datas ADD COLUMN another_code INTEGER DEFAULT 0;
UPDATE datas SET another_code = 17955766 WHERE id = 78734254;
UPDATE datas SET another_code = 17732278 WHERE id = 13857930;
UPDATE datas SET another_code = 10000050 WHERE id = 1784686;
UPDATE datas SET another_code = 10000060 WHERE id = 11082056;
UPDATE datas SET another_code = 10000070 WHERE id = 46232525;

ALTER TABLE datas ADD COLUMN scale INTEGER DEFAULT 0;
UPDATE datas SET scale = (level >> 24) & 0xff, level = level & 0xffff WHERE (type & 0x1000000) != 0;

ALTER TABLE datas ADD COLUMN marker INTEGER DEFAULT 0;
UPDATE datas SET marker = def, def = 0 WHERE (type & 0x4000000) != 0;

ALTER TABLE datas ADD COLUMN setcode1 TEXT DEFAULT '[]';
UPDATE datas 
SET setcode1 = CASE
    WHEN setcode & 0xffff = 0
        THEN '[]'
    WHEN ((setcode >> 16) & 0xffff) = 0
        THEN json_array(setcode & 0xffff)
    WHEN ((setcode >> 32) & 0xffff) = 0
        THEN json_array(setcode & 0xffff, (setcode >> 16) & 0xffff)
    WHEN ((setcode >> 48) & 0xffff) = 0
        THEN json_array(setcode & 0xffff, (setcode >> 16) & 0xffff, (setcode >> 32) & 0xffff)
    ELSE
        json_array(setcode & 0xffff, (setcode >> 16) & 0xffff, (setcode >> 32) & 0xffff, (setcode >> 48) & 0xffff)
END
WHERE setcode != 0;
UPDATE datas SET setcode1 = json_array(143, 84, 89, 130, 314) WHERE id IN (8512558, 55088578);
ALTER TABLE datas DROP COLUMN setcode;
ALTER TABLE datas RENAME COLUMN setcode1 TO setcode;
ALTER TABLE texts RENAME COLUMN "desc" TO description;

CREATE TABLE IF NOT EXISTS schema_version (version INTEGER NOT NULL) STRICT;
DELETE FROM schema_version;
INSERT INTO schema_version (version) VALUES (2);
COMMIT;

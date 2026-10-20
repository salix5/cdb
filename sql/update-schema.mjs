import { readFileSync } from "node:fs";
import { join } from "node:path";

/**
 * Update the database schema by executing the SQL statements in `migrate.sql`.
 * @param {import("node:sqlite").DatabaseSync} db 
 */
export function update_schema(db) {
	const sql_schema = readFileSync(join(import.meta.dirname, "migrate.sql"), "utf8");
	db.exec(sql_schema);
}

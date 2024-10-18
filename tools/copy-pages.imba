###

Copy grav pages to meltdown pages directory

⚠️ Destination files will be overwritten.

Grav pages are in a file structure like this:

+ ./pages/01.home/default.md
+ ./pages/02.typography/default.md

Copying to meltdown will result in:

+ ./pages/index.md
+ ./pages/typography.md

###

import { join } from "path"
import { copyFile } from "fs"
import isNil from "lodash/isNil"
import map from "async/map"
import fg from "fast-glob"

const projectPath = join __dirname, ".."
const gravPagesPath = join projectPath, "config", "www", "user", "pages"
const metldownPagesPath = join projectPath, "app", "src", "pages"
const patterns = ["{gravPagesPath}/**/*.md"]
const fgOpts = { onlyFiles: true }
const numberPattern = /\d{2,}\./
const defaultPattern = /\/default/
const blank = ""

def copy item, done
	const { gravAbsolutePath: src, meltdownAbsolutePath: dest } = item
	console.log "copy", src, "➡️", dest
	copyFile src, dest, done

def listSuccess paths
	const copyItems = paths.map do(gravAbsolutePath)
		const meltdownRelativePath = gravAbsolutePath
			.replace("{gravPagesPath}/", blank)
			.replace(numberPattern, blank)
			.replace(defaultPattern, blank)
			.replace("home", "index")
		const meltdownAbsolutePath = join metldownPagesPath, meltdownRelativePath
		{ gravAbsolutePath, meltdownAbsolutePath }
	map copyItems, copy, do(err)
		if not isNil err
			const { message, stack } = err
			console.error "error copying", message, stack
			return
		console.log "done copying grav pages to meltdown pages"

def listFail err
	const { message, stack } = err
	console.error "error listing grav pages", message, stack

fg(patterns, fgOpts)
	.then(listSuccess)
	.catch(listFail)
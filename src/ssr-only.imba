import express from 'express'
# import {App} from './app'
import {People } from './people'
import edgedb from 'edgedb'
const { performance } = require('perf_hooks');
const inertia = require("inertia-node");
const ASSET_VERSION = "1";
import index from './index.html'

def _html pageString\string, viewData
	let page = index.body.replace ",,,", pageString
	return String page

const server = express!
server.use inertia(_html, ASSET_VERSION)


server.get("/") do(req,res)
	console.log "get /"
	const conn = await edgedb();

	const people = await conn.query\<{first_name:string, last_name:string}[]> 
		"SELECT Person \{id, first_name, last_name\}"

	req.Inertia.render 
		component: "people-page"
		props: 
			people: people
	
	# let html = <html>
	# 	<head>
	# 		<title> "Application"
	# 		# generate stylesheet for the ./app entrypoint
	# 		<style src='./app'>
	# 	<body>
	# 		# just render the App tag - routing happens inside
	# 		<App>

	# res.end(String(html))



server.post "/people" do(req, res)
	const conn = await edgedb!
	console.log "testing"
	try
		await conn.query
			"INSERT Person \{
			first_name := <str>$first_name,
			last_name := <str>$last_name,
			\}",
			{
				first_name: "Abdellah",
				last_name: "Alaoui"
			}
	catch e
		console.log(e)
	req.Inertia.redirect "/"
    
imba.serve server.listen(process.env.PORT or 3000)

# srv.get("/people") do(req,res)
# 	const conn = await edgedb();

# 	const t0 = performance.now()

# 	const people = await conn.query\<{first_name:string, last_name:string}[]> 
# 		"SELECT Person \{id, first_name, last_name\}"
# 	const t1 = performance.now()
# 	console.log("Call to doSomething took {t1 - t0} milliseconds.")
# 	let html = <html>
# 		<head>
# 			<title> "Application"
# 			# generate stylesheet for the ./app entrypoint
# 			# <style src='./app'>
# 			<style src='./people'>
# 			<script type="module" src='./people'>

# 		<body>
# 			# just render the App tag - routing happens inside
# 			<People people=people>	
# 	res.end String(html)

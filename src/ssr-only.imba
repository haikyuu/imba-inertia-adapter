import express from 'express'
# import {App} from './app'
import {People } from './people'
import edgedb from 'edgedb'
const { performance } = require('perf_hooks');
const inertia = require("inertia-node");
const ASSET_VERSION = "1";
import index from './index.html'
# import getPeople from './queries/getPeople.edgeql'
const bodyParser = require('body-parser')

def _html pageString\string, viewData
	let page = index.body.replace ",,,", pageString
	return String page

const server = express!
server.use bodyParser.json!
server.use inertia(_html, ASSET_VERSION)


server.get("/people") do(req,res)
	console.log "get /people"
	const conn = await edgedb();

	const people = await conn.query\<{first_name:string, last_name:string, id:string}[]> 
		"SELECT Person \{id, first_name, last_name\}"

	req.Inertia.render 
		component: "people-page"
		props: 
			people: people

server.get("/movies") do(req,res)
	console.log "get /movies"
	const conn = await edgedb();

	const movies = await conn.query\<{title:string, year:number, id:string}[]> 
		"SELECT Movie \{id, title, year\}"

	req.Inertia.render 
		component: "movies-page"
		props: 
			movies: movies


server.post "/people" do(req, res)
	const conn = await edgedb!
	const user = req.body
	try
		await conn.query
			"INSERT Person \{
			first_name := <str>$first_name,
			last_name := <str>$last_name,
			\}",
			user
	catch e
		console.log(e)
	req.Inertia.redirect!
    
server.delete "/people" do(req, res)
	const conn = await edgedb!
	console.log "testing", req.query
	const id = req.query.id
	try
		await conn.query
			"DELETE Person FILTER .id = <uuid>$id",
			id: "{id}"
	catch e
		console.log(e)
	req.Inertia.redirect!

imba.serve server.listen(process.env.PORT or 3000)
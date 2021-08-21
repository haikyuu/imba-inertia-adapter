import express from 'express'
# import {App} from './app'
import {People } from './people'
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

let people = []
let movies = []
let id = 0
server.get("/people") do(req,res)
	req.Inertia.render 
		component: "people-page"
		props: 
			people: people

server.get("/movies") do(req,res)
	req.Inertia.render 
		component: "movies-page"
		props: 
			movies: movies


server.post "/people" do(req, res)
	const person = req.body
	people.push {...person, id: `{id++}`}
	req.Inertia.redirect!
    
server.post "/movies" do(req, res)
	const movie = req.body
	
	movies.push {...movie, id: `{id++}`}
	req.Inertia.redirect!

server.delete "/people" do(req, res)
	const id = req.query.id
	people = people.filter do(person) person.id !== id

	req.Inertia.redirect!

server.delete "/movies" do(req, res)
	const id = req.query.id
	movies = movies.filter do(movie) movie.id !== id

	req.Inertia.redirect!

imba.serve server.listen(process.env.PORT or 3000)
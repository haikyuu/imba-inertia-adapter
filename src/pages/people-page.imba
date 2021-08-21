# import 'imba/reset.css'
import { Inertia } from '@inertiajs/inertia'

let first_name = "first";
let last_name = "last";

class Form
	def post url,body
		return window.fetch url, {
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'Content-Type': 'application/json'
			},
			body: JSON.stringify body
		}


tag people-page
	prop props\{props: {people: \{first_name: string, last_name: string}[]}}
	def submit
		console.log "test"
		let f = new Form
		Inertia.post "/people", {first_name, last_name}
	def render
		console.log "pp", props
		<self>
			<div[c:blue6]> "Welcome!"
			<div> "Url is {document.location.href}"
			<ul> for person in props.props.people
				<li> "movie id: {person.first_name}  {person.last_name}"
			<h1> "Create a Person"
			<form>
				<input type="text" bind=first_name>
				<input type="text" bind=last_name>
				<button type="button" @click=self.submit> "submit"

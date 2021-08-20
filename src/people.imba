# import 'imba/reset.css'

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


export tag People
	prop people\{first_name: string, last_name: string}[]
	def submit
		console.log "test"
		let f = new Form
		f.post "/test", {}
	def render
		<self>
			<div[c:blue6]> "Welcome!"
			<div> "Url is {document.location.href}"
			<ul> for person in people
				<li> "movie id: {person.first_name}  {person.last_name}"
			<h1> "Create a Person"
			<form>
				<input type="text" bind=first_name>
				<input type="text" bind=last_name>
				<button type="button" @click=self.submit> "submit"

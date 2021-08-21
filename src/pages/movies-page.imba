# import 'imba/reset.css'
import { Inertia } from '@inertiajs/inertia'
# import useRemember from '../inertia/useRemember'

let title = "title";
let year = 2021

tag movies-page
	prop props\{props: {movies: \{title: string, year: number, id: string}[]}}
	def submit
		console.log "test"
		Inertia.post "/movies", {title, year}
	def deleteMovie id
		console.log "deleting", id
		Inertia.delete "/movies?id={id}"
	def render
		console.log "pp", props
		<self>
			<div[c:blue6]> "Welcome!"
			<div> "Url is {document.location.href}"
			<a href="/people"> "people"
			<ul> for movie in props.props.movies
				<li>
					<span> "movie: {movie.id} {movie.title}  {movie.year}"
					<button @click=deleteMovie(movie.id)> "delete"
			<h1> "Create a Movie"
			<form>
				<input type="text" bind=title>
				<input type="text" bind=year>
				<button type="button" @click=self.submit> "submit"

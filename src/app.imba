import 'imba/reset.css'
import { People } from './people'

export tag App
	def render
		<self>
			<div[c:blue6]> "Welcome!"
			<div> "Url is {document.location.href}"
			<People movies=[]>
			if $web$
				<p> "This is rendered from the client"
			else
				<p> "This is rendered from the server"

			<header[d:hflex]>
				<a href="/home"> "Home"
				<a href="/about"> "About"

			<div route="/home">
				<div> "Welcome"
				<a href="/about"> "About"
				
			<div route="/about">
				<div> "About us"
				<a href="/home"> "Home"
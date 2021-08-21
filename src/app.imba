import {createInertiaApp} from './inertia'
import './pages/people-page'

createInertiaApp
	resolve: do(name) name
	setup: do({ el, App, props })
		imba.mount <{App} props=props>
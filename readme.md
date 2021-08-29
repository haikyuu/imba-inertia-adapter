# Imba Inertia Adapter

## Install
- npm: `npm install imba-inertia-adapter`
- pnpm: `pnpm add imba-inertia-adapter`
- yarn : `yarn add imba-inertia-adapter`

## Ping CRM implementation
https://github.com/haikyuu/perfect-stack

## Full API docs
For more documentation, please refer to [inertia.js website](https://inertiajs.com). As the frontend adapters are quite similar in usage.

## Usage
This will be the entry point for your app
``` 
import { createInertiaApp } from 'imba-inertia-adapter'

createInertiaApp
	resolve: do(name) name
	setup: do({ el, App, props })
		imba.mount <{App} props=props>
```

## inertia-link and inertia-button-link
Those two components are automatically registered when you import from the main entry point.
They have the same attributes as their react/vue counterparts except `as` which is currently unsupported. Instead use the `inertia-button-link`.
```
<inertia-button-link href="/login" method="delete"> "Logout"
<inertia-link href="/users"> "users"
```

## Form Helper

```
import { Form } from 'imba-inertia-adapter'

tag edit-contacts-page
	prop props
	def setup
		const {last_name = "", first_name = ""} = props.props.contact;
		self.form = new Form
			first_name: first_name
			last_name: last_name
	def render
		const {contact} = props.props
		<self>
			"Loading" if form.processing
			<form @submit.prevent=form.put("/contacts/{contact.id}")>
				<input bind=form.data.first_name error=form.errors.first_name>
				<button type="submit"> "Submit"

```

## Access the page object from deep down the tree
```
#context.currentPage.page.props
```

## Flash messages
If your backend adapter supports them, they can be accessed like regular props
```
#context.currentPage.page.props.flash

#or

props.props.flash
```

## Notes
- Each page is passed a `props` prop with a nested `props`. --> access it with `props.props.data`.
- You can change forms by simple assignment: `form.data.name = "Abdellah"`


## License
MIT License.
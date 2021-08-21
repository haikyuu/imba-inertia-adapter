import { createHeadManager, Inertia } from '@inertiajs/inertia'

let headManager 
let current
export tag InertiaApp
	prop props
	def setup
		current =
			component: props.initialComponent || null,
			page: props.initialPage,
			key: null
		headManager = createHeadManager
			typeof window === 'undefined',
			props.titleCallback || do(title) title,
			props.onHeadUpdate || do(a) a
		Inertia.init
			initialPage: props.initialPage,
			resolveComponent: props.resolveComponent,
			swapComponent: do(obj)
				// we use await because swapComponent should return a promise
				current = await {
					component: obj.component,
					page: obj.page,
					key: obj.preserveState ? current.key : Date.now()
				}
				render!
	def render
		if (!current.component)
			<self>
				<span> "no current component"
		let props = current.page.props
		console.log "props render", props
		<self>
			<{current.component} props={props}>
const elementEventListeners = new Map()

export const addEventListener = (element, event, callback, opts = undefined) => {
  // we get the listeners for the element or create a new Map
  const listeners = elementEventListeners.get(element) || new Map()

  // we get the existing listeners for the event or create an empty array
  const existingListeners = listeners.has(event) ? listeners.get(event) : []

  // we add the new callback to the existing listeners
  listeners.set(event, [...existingListeners, callback])

  // we set the new listeners for the element
  elementEventListeners.set(element, listeners)

  // we add the actual event listener to the element
  element.addEventListener(event, callback, opts)
}

// removes all event listeners for the given element and event
export const removeAllEventListeners = (element, event) => {
  const listeners = elementEventListeners.get(element)
  if (!listeners) return

  const callbacks = listeners.get(event)
  if (!callbacks) return

  callbacks.forEach(callback => element.removeEventListener(event, callback))
  listeners.delete(event)
}

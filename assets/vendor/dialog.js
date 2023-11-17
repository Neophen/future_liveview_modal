import { addEventListener, removeAllEventListeners } from "./eventListeners"

// Checks if the click event is inside the dialog BoundingClientRect
const clickIsInDialog = (dialog, event) => {
  const { left, top, width, height } = dialog.getBoundingClientRect();
  const { clientX: x, clientY: y } = event;

  return (top <= y && y <= top + height && left <= x && x <= left + width);
}

// Calls the cancel callback if it exists
const maybeCallCancel = (dialog) => {
  const cancel = dialog.getAttribute('data-cancel')

  if (cancel) {
    window.execJS(dialog, cancel)
  }
}

// Closes the dialog if the click is outside of it
const maybeCloseDialog = (event) => {
  const dialog = event.target
  // Prevent the dialog from closing when clicking on elements inside the dialog
  if (dialog?.nodeName !== "DIALOG") {
    return;
  }

  // Prevent the dialog from closing when clicking within the dialog boundaries
  if (clickIsInDialog(dialog, event)) {
    return;
  }


  dialog.close();
  maybeCallCancel(dialog);
}

export const setupDialogEvents = () => {
  // We move this from app.js to here to keep all the logic in one place
  window.addEventListener("hide-dialog-modal", event => event.target?.close())

  // We move this from app.js and update it to use the new event listener functions
  window.addEventListener("show-dialog-modal", event => {
    if (!event.target || !(event.target instanceof HTMLDialogElement)) {
      return;
    }

    event.target.showModal()

    // We add the ligth dismiss on click outside of the dialog
    addEventListener(event.target, "click", maybeCloseDialog, false)

    // Let's not forget to clean up the event listeners when the dialog is closed
    addEventListener(event.target, "close", () => {
      removeAllEventListeners(event.target, "click")
      removeAllEventListeners(event.target, "close")
    }, false)
  })
}

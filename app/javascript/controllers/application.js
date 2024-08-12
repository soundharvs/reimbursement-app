import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

document.addEventListener('DOMContentLoaded', () => {
    // Get flash messages from the document body
    const notice = document.body.dataset.flashNotice;
    const alert = document.body.dataset.flashAlert;
  
    // Display notice message
    if (notice) {
      alert('notice', notice);
    }
  
    // Display alert message
    if (alert) {
      alert('alert', alert);
    }
  });
  
  function alert(type, message) {
    const alertBox = document.createElement('div');
    alertBox.className = `alert alert-${type}`;
    alertBox.innerText = message;
    document.body.insertBefore(alertBox, document.body.firstChild);
  
    // Automatically hide the alert after 5 seconds
    setTimeout(() => alertBox.remove(), 5000);
  }
  
export { application }

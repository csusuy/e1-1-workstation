document.addEventListener('DOMContentLoaded', () => {
  console.log('[Workstation] Developer workstation web dashboard loaded.');
  
  // Display current access port dynamically if accessed via browser
  const portSpan = document.getElementById('host-port');
  if (portSpan && window.location.port) {
    portSpan.textContent = `${window.location.port} (Current)`;
  }
});

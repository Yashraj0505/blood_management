async function loadDonors() {
  const res = await fetch("http://localhost:5000/donors");
  const data = await res.json();
  renderTable("donorTable", data);
}

async function loadRecipients() {
  const res = await fetch("http://localhost:5000/recipients");
  const data = await res.json();
  renderTable("recipientTable", data);
}

function renderTable(containerId, data) {
  if(!data || data.length === 0){
    document.getElementById(containerId).innerHTML = "<p>No data available</p>";
    return;
  }
  let html = "<table><tr>";
  for(let key in data[0]) html += `<th>${key}</th>`;
  html += "</tr>";
  data.forEach(row => {
    html += "<tr>";
    for(let key in row) html += `<td>${row[key]}</td>`;
    html += "</tr>";
  });
  html += "</table>";
  document.getElementById(containerId).innerHTML = html;
}

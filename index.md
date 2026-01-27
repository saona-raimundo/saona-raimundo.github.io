---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
list_title: News
---

<div vocab="https://schema.org/" typeof="Person">
	<div>
		<a property="sameAs" href="https://saona-raimundo.github.io/">
		<img src="me.jpg" 
		class="galleryItem"
		width=200px>
		</a>
	</div>
	<div>
		I am a
		<span vocab="https://schema.org/" typeof="OrganizationRole">
			<span property="roleName">
				Fellow
			</span>
			at
			<span typeof="Organization">
				<a href= "https://www.lse.ac.uk/">
				<span property="sameAs" content="https://en.wikipedia.org/wiki/London_School_of_Economics">
					<span property="name">London School of Economics and Political Science (LSE)</span>
				</span>
				</a>
			</span>
			<meta property="startDate" content="2025-09-01">
			.
		</span>
	</div>
	<div>
		<p>
			My research uses tools from Mathematics, Game Theory, and Computer Science. I work with continuous and discrete models, prove theoretical existence theorems and code efficient algorithms, and work with both dynamic online and static offline settings. I see my work as developing tools to provide new insights on situations involving uncertainty, and I am happy to hear about your problems.
		</p>
		<p>
			I joined LSE in 2025 as a Fellow in Mathematics. 
Before this, I completed my PhD under the supervision of <a href= "https://pub.ista.ac.at/~kchatterjee/">Krishnendu Chatterjee</a> at the <a href= "https://www.ista.ac.at">Institute of Science and Technology Austria</a> on the robustness of solutions in Game Theory.
		</p>

	</div>
	<div>
		<address itemprop="email">
			📧 E-mail: raimundo.saona (at) gmail (dot) com 
		</address>
	</div>
</div>

# <a href="{{site.baseurl}}/interests/"> Interests </a>

Game Theory, Probability Theory, Algorithmic Game Theory, Stochastic Analysis, Optimal Control, Optimal Stopping, Imprecise Probability Theory

<div id="events"></div>

<script>
const CALENDAR_ID = 'a0bc276d180aec3fd9375f5847b01dfc79bb6195e364f6be97cd2ea61c9aca07@group.calendar.google.com';
const API_KEY = 'AIzaSyCXAW1kzho5aFrXh6sCyBUSFuqPyQOLLJs';
const MAX_EVENTS = 10;

async function fetchEvents() {
  const now = new Date().toISOString();
  const url = `https://www.googleapis.com/calendar/v3/calendars/${encodeURIComponent(CALENDAR_ID)}/events?` +
    `key=${API_KEY}&timeMin=${now}&maxResults=${MAX_EVENTS}&singleEvents=true&orderBy=startTime`;

  try {
    const res = await fetch(url);
    const data = await res.json();
    if (data.error) throw new Error(data.error.message);
    renderEvents(data.items || []);
  } catch (err) {
    document.getElementById('events').innerHTML = 
      `<p style="color:#c00">Could not load events: ${err.message}</p>`;
  }
}

function renderEvents(events) {
  const container = document.getElementById('events');
  
  if (events.length === 0) {
    container.innerHTML = '';
    return;
  }

  container.innerHTML = `
    <style>
      #events .event { padding: 0.75rem 0; border-bottom: 1px solid #eee; }
      #events .event:last-child { border-bottom: none; }
      #events .event-date { font-size: 0.85rem; color: #666; margin-bottom: 0.25rem; }
      #events .event-title { font-weight: 500; }
      #events .event-location { font-size: 0.85rem; color: #888; margin-top: 0.25rem; }
    </style>
    <h2>Next Events</h2>
  ` + events.map(e => {
    const start = e.start.dateTime || e.start.date;
    const dateStr = formatDate(start, !e.start.dateTime);
    const location = e.location ? `<div class="event-location">📍 ${e.location}</div>` : '';
    return `
      <div class="event">
        <div class="event-date">${dateStr}</div>
        <div class="event-title">${e.summary}</div>
        ${location}
      </div>
    `;
  }).join('');
}

function formatDate(dateStr, allDay) {
  const date = new Date(dateStr);
  const opts = { weekday: 'short', month: 'short', day: 'numeric' };
  if (!allDay) { opts.hour = 'numeric'; opts.minute = '2-digit'; }
  return date.toLocaleDateString('en-GB', opts);
}

fetchEvents();
</script>
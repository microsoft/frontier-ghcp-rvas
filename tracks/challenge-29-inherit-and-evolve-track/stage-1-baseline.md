# Stage 1: Establish the Baseline

**Difficulty:** ⭐⭐ | **Time:** 30 min

Keep application code unchanged in this stage. You need to know what the
inherited version does before asking Copilot to change it.

## Tasks

1. Complete setup in a disposable clone. If you used the devcontainer, skip
   manual clean-start setup: it has already run. The post-create step also
   validates the starter but leaves the application stopped.
2. From the challenge folder, check the starter:

   ```bash
   dotnet restore EquipmentBooking.sln
   bash scripts/validate-starter.sh
   dotnet test EquipmentBooking.sln
   ```

3. Start the application from that same folder in your local or devcontainer
   terminal:

   ```bash
   dotnet run --project src/EquipmentBooking.Web --urls http://0.0.0.0:5080
   ```

4. Open `http://localhost:5080` in your browser, or use the devcontainer's
   forwarded port 5080. Keep port forwarding private. Browse equipment at `/`,
   open `/Reservations` for booking and history, and find the demo maintenance
   controls at `/Admin`. Identify the synthetic employee selector.
5. Use fixed dates in October 2030 to check availability. Make a reservation
   on available equipment and find it in the reservation list. Observe
   cancellation and maintenance behavior without repairing anything yet.
6. Record the commands and results in your working note. Separate an
   environment failure from an application symptom.
7. Draft brief repository instructions from the facts you have checked.
   Create the small Discovery Reviewer agent and regression-test skill
   described in the overview. You will refine them during the next stages.

Stop a foreground local run with `Ctrl+C`. Restart it with the same launch
command. Keep your test data until you have recorded any useful observation.
The local database is
`src/EquipmentBooking.Web/App_Data/equipment-booking.db`, relative to the
challenge folder. `Booking__DatabasePath` overrides that location; relative
override paths resolve against the web project's content root.

### Seeded Lab Data

The UI defaults to October 10 to October 12, 2030, regardless of today's date.
The thermal camera has a reservation for that range. The laser level has a
cancelled reservation for it; compare its history with the availability shown.
The inspection tablet starts available, and the moisture meter is under
maintenance.

The employee choices are Alex Morgan, Sam Rivera, and Taylor Chen. These are
synthetic identities, not authenticated users.

### Optional Docker Run

The simplest Docker path uses a **host terminal**, outside the devcontainer.
It requires a running Docker daemon. Stop any web process using port 5080,
then run these commands from the challenge folder on the host. The final `.`
is the application build context.

```bash
docker build -t challenge-29-booking .
docker volume create challenge-29-booking-data
docker run -d --name challenge-29-booking \
  -p 127.0.0.1:5080:8080 \
  -e Booking__DatabasePath=/data/bookings.db \
  -v challenge-29-booking-data:/data \
  challenge-29-booking
```

Open `http://localhost:5080`. The named volume stores the database separately
from the container. If you run Docker commands inside the devcontainer, its
CLI uses the host engine: port 5080 is published on the host, and the
devcontainer's forwarded URL may not reach it.

Stop and restart without losing data:

```bash
docker stop challenge-29-booking
docker start challenge-29-booking
```

The .NET launch and Docker run use separate databases. Run solution tests in
your development environment.

## Verification

- The browser loads the starter, and you can find its existing booking
  workflows.
- `dotnet test EquipmentBooking.sln` and `bash scripts/validate-starter.sh`
  pass against the unchanged starter.
- The baseline note records any unexpected behavior without claiming a cause.
- No application changes or waitlist implementation have been made.

**Passing baseline tests are incomplete evidence.** The cancellation defect is
deliberately present, and the starter checks are not a waitlist acceptance
suite.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can explain launch output and help locate entry points. You decide
whether a failure comes from setup or the application. Keep observed behavior
separate from an explanation that merely sounds plausible.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Discover the Application](stage-2-discovery.md)

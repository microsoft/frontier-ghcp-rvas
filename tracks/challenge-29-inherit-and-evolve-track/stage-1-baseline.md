# Stage 1: Establish the Baseline

**Difficulty:** ⭐⭐ | **Time:** 30 min

Do not change application code in this stage. First learn what the inherited
version does.

## Tasks

1. Set up a disposable clone. If you use the devcontainer, skip the manual
   clean-start setup. Its post-create step already validates the starter and
   leaves the application stopped.
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

4. Open `http://localhost:5080` in your browser, or use the devcontainer port
   forwarded from 5080. Keep the forwarded port private. Browse equipment at
   `/`, use `/Reservations` to book equipment and view its history, and find
   the demo maintenance controls at `/Admin`. Find the synthetic employee
   selector.
5. Use fixed dates in October 2030 to check availability. Reserve available
   equipment and find the reservation in the list. Check cancellation and
   maintenance, but do not fix anything yet.
6. Record the commands and results in your working note. Distinguish setup
   failures from application symptoms.
7. Write short repository instructions based on facts you checked. Create the
   Discovery Reviewer agent and regression-test skill described in the
   overview. You will refine both in later stages.

Stop a foreground local run with `Ctrl+C`, then restart it with the same
command. Keep test data until you have recorded useful observations.
The local database is
`src/EquipmentBooking.Web/App_Data/equipment-booking.db`, relative to the
challenge folder. `Booking__DatabasePath` overrides that location; relative
override paths resolve against the web project's content root.

### Seeded Lab Data

The UI defaults to October 10 through October 12, 2030, regardless of the
current date. The thermal camera has a reservation for that range. The laser
level has a cancelled reservation for the same dates. Compare its history with
the availability shown. The inspection tablet starts available. The moisture
meter starts under maintenance.

The employee choices are Alex Morgan, Sam Rivera, and Taylor Chen. These are
synthetic identities, not authenticated users.

### Optional Docker Run

Use a **host terminal** outside the devcontainer for the simplest Docker path.
It needs a running Docker daemon. Stop any web process on port 5080, then run
these commands from the challenge folder on the host. The final `.` is the
application build context.

```bash
docker build -t challenge-29-booking .
docker volume create challenge-29-booking-data
docker run -d --name challenge-29-booking \
  -p 127.0.0.1:5080:8080 \
  -e Booking__DatabasePath=/data/bookings.db \
  -v challenge-29-booking-data:/data \
  challenge-29-booking
```

Open `http://localhost:5080`. The named volume keeps the database outside the
container. Docker commands run inside the devcontainer still use the host
engine. Port 5080 is published on the host, so the devcontainer's forwarded URL
may not reach it.

Stop and restart without losing data:

```bash
docker stop challenge-29-booking
docker start challenge-29-booking
```

The .NET launch and Docker run use separate databases. Run solution tests in
your development environment.

## Verification

- The browser loads the starter and shows its existing booking workflows.
- `dotnet test EquipmentBooking.sln` and `bash scripts/validate-starter.sh`
  pass against the unchanged starter.
- The baseline note records unexpected behavior without guessing at a cause.
- No application changes or waitlist implementation have been made.

**Passing baseline tests are incomplete evidence.** The cancellation defect is
deliberately present, and the starter checks are not a waitlist acceptance
suite.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can explain launch output and help find entry points. You decide
whether a failure comes from setup or the application. Keep what you observed
separate from guesses about why it happened.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Discover the Application](stage-2-discovery.md)

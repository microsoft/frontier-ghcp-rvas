FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source
COPY src/EquipmentBooking.Web/EquipmentBooking.Web.csproj src/EquipmentBooking.Web/
RUN dotnet restore src/EquipmentBooking.Web/EquipmentBooking.Web.csproj
COPY src/ src/
RUN dotnet publish src/EquipmentBooking.Web/EquipmentBooking.Web.csproj --no-restore -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
ENV ASPNETCORE_HTTP_PORTS=8080 \
    Booking__DatabasePath=/data/bookings.db
RUN mkdir /data && chown app:app /data
COPY --from=build /app .
USER app
VOLUME /data
EXPOSE 8080
ENTRYPOINT ["dotnet", "EquipmentBooking.Web.dll"]

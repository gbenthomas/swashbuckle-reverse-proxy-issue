
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

COPY . .

RUN dotnet restore
RUN dotnet publish /warnaserror -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app

COPY --from=build /app/out ./

CMD dotnet reverse-proxy-issue.dll
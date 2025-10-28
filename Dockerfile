# Use official .NET SDK to build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet publish -c Release -o out

# Use runtime image to run the app
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .

# Copy your SQLite database if needed
COPY Data/budget.db ./Data/budget.db

# Run the app
ENTRYPOINT ["dotnet", "BudgetApp.dll"]

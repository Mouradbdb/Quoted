# Quotes App

This project is a mobile app built with Flutter, backed by an Express.js server for creating and reading famous quotes. The app allows users to browse, create, and save quotes.

## Features
- **Create Quotes**: Add your own custom quotes to the app.
- **Read Famous Quotes**: Fetch a collection of famous quotes.
- **Express Backend**: The server handles quote creation and provides the famous quotes.
- **Mobile Integration**: The Flutter app communicates with the backend to display and create quotes.

## Getting Started

Follow these steps to get the project up and running:

### 1. Run the Server
The backend server is located in the `dist` folder. Start the server by running the precompiled `server.js` file using Node.js.

```bash
node dist/server.js
```
## 2. Find Your IP Address

To configure the app, you'll need your computer's IP address. Here's how to find it:

1. Open Command Prompt and run the following command:

    ```bash
    ipconfig
    ```

2. Look for the line that says **IPv4 Address**, and take note of your IP address.

## 3. Configure the Mobile App

In the Flutter mobile app, go to the settings page and enter your computer’s IP address. This will allow the app to fetch quotes from the backend server.

## Technologies Used

- **Flutter**: Frontend framework for building the mobile app.
- **Express.js**: Backend framework for building the API server.
- **Prisma**: ORM used to interact with the database.


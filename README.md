# JonasHeilmann/MessageBoard

## Description

This repository is the result of my attempt at the *Storytel Backend Coding Challenge* as part of my application at Storytel in spring 2020. 

The application provides a REST-API for creating, updating and deleting messages with user authentication as well as shows information for any message that has already been created for anyone requesting.
Secondly, a UI interface is provided that offers the same functionality in a visual form.

Some resources used like css and fonts are taken from Storytel's official website to match their look and feel.

## Requirements

This application currently works these main dependencies:

* Rails 6.0.X
* Ruby 2.7.X
* SQLite3 3.28.X
* Yarn 1.22.X

## Installation

To install this rails application run the following command from the root directory.

```
bundle install
```

As the app makes use of an in-memory database solution for the `development-` and `test-environments`, no database-setup and/ or -migration is required.

If you do not have yarn installed use the following command to install it through `homebrew` on macOS or find out how to install yarn your operating system [here](https://classic.yarnpkg.com/en/docs/install/#mac-stable).

```
 brew install yarn
```

Lastly install all required `node modules` with the following command.

```
yarn install --check-files
```

## Usage

To get started run the server with 

```
rails server
```

and access it through the default port `3000` on [http://localhost:3000](`http://localhost:3000`).

#### Docker

If you want to use `Docker` to host your application use the included `docker-compose.yml` file to create a container. Execute

```
docker-compose build app
```

from your terminal and set the state to up with the following command.

```
docker-compose up -d app
```

The server can now be accessed from your host machine just like hosting it yoruself on [http://localhost:3000](`http://localhost:3000`).

#### API

The REST-API is not configured in seperate controllers but instead uses the same ones that power the HTML routes. Thus, for requests that expect a `JSON response`, the header

```
ACCEPT application/json
```

needs to be send in requests towards the API.

#### Authentication

The user-management is handeled by making use of the gem [Devise](https://github.com/heartcombo/devise). For token authentication in the API-requests the gem [Simple Token Authentication](https://github.com/gonzalo-bulnes/simple_token_authentication) is used.

In requests that use a `create, update` or `delete` action, the two following additional headers need to be sent to authenticate the requesting user.

```
X-User-Email *email*
X-User-Token *token*
```
The `*token*` can be fetched from the creation of a new user

```
{
    "user": {
        "email": "*email*",
        "password": "*password*"
    }
}

POST http://localhost:3000/users
```

or by signing in with an existing user.

```
{
    "user": {
        "email": "*email*",
        "password": "*password*"
    }
}

POST http://localhost:3000/users/sign_in
```

#### UI

The UI layer of the application can be accessed from the browser on [http://localhost:3000](`http://localhost:3000`). Here, the same functionality is provided as on the API in a visual form. You can view any message that has previously been created. To write your own messages, create a new user by signing up. Edit or delete messages you have created before while you are signed in.

## Testing

For testing the ruby testing tool `RSpec` is used. To run test simple execute the following command from your terminal.

```
rspec
```

If you want to test individual files run the following command, replacing `*path_to_file*` with the path to the file you want to test.

```
rspec *path_to_file*.rb
```

## Configuration

#### ENV Variables

To suppress some deprecation warnings that show with ruby 2.7.0 create a `.env` file according to `.env.example` and run the following command before starting the server.

```
source .env
```

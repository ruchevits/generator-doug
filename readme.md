## Installation

First, install [Yeoman](http://yeoman.io) and generator-doug using [npm](https://www.npmjs.com/) (we assume you have pre-installed [node.js](https://nodejs.org/)).

```bash
npm install -g yo
npm install -g generator-doug
```

Then generate your new project:

```bash
yo doug
```

## Generated structure

- src
	- contracts
		- keystore.sol
	- framework
		- child.sol
		- entity.sol
		- main.sol
		- provider.sol
	- libraries
		- strings.sol
	- utils
		- owned.sol
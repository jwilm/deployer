deployer
========

Automatically deploy your software with real time monitoring of the deploy process

![Deployer](https://f.cloud.github.com/assets/4285147/1895598/e830e4cc-7b43-11e3-9ac5-59df648d8b16.png)

## Status
This is currently just a UI Mockup and Grunt build system for development. As
features are added, this section of the readme will be updated to reflect the
current state of deployer.

## How it works
Deployer listens for GitHub webhooks on `POST /deploy`. You may configure your
own logic for which pushes to run a deployment on, but the default is to deploy
any commit to _master_. This makes sense if your _master_ branch is blessed, and
you are doing continuous integration. The deploy process itself is a _bash_
script that **you** provide. Any output on `stdout` and `stderr` is forwarded
to the client. Deploys returning 0 are considered successful, and non zero
return codes indicate a failure. Node that if there is output captured from
`stderr` during the deploy and the process returns 0, the deploy is marked
"successful with warnings" (corresponding to the yellow badge in the above
screen shot).

## Planned Features
- Configure single git repository and deploy script
- Real time display of any output of the deploy script
- Deploy statistics (frequency, time, duration, etc)

## Getting started
You must build the project locally for the time being. Once we have some
functional back end, we will provide production ready `.zip` files on the
releases page.

### Dependencies
You will need 
- Ruby
- Node.js
- Grunt (`npm install -g grunt-cli`)

### Building
The following commands will get you running
```bash
bundler install
npm install
grunt bootstrap
```

The compiled `.js` and `.css` will be placed in `public/`. For now, all you can
really do is load up index.html in a browser to preview the UI.

## Contributing
We are using **Sass** for styling, and **CoffeeScript** for scripting. You may
have noticed that we do not yet have a coffee-script builder in the Gruntfile.

Additional grunt targets that are useful to you:
- `build`: Build CSS, Compile Templates, Concatenate JS and CSS (normalize.css)
- `development`: Run `build` and `watch` for changes

The default task is `development`.

## License
The MIT License (MIT)

Copyright (c) 2014 Joe Wilm

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

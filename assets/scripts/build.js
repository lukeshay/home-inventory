const process = require('process');

// eslint-disable-next-line node/no-unpublished-require
const {build} = require('esbuild');

const args = new Set(process.argv.slice(2));
const watch = args.has('--watch');
const deploy = args.has('--deploy');

const loader = {
    // Add loaders for images/fonts/etc, e.g. { '.svg': 'file' }
};

const plugins = [
    // Add and configure plugins here
];

let opts = {
    bundle: true,
    entryPoints: ['js/app.js'],
    loader,
    logLevel: 'info',
    outdir: '../priv/static/assets',
    plugins,
    target: 'es2017',
};

if (watch) {
    opts = {
        ...opts,
        sourcemap: 'inline',
        watch,
    };
}

if (deploy) {
    opts = {
        ...opts,
        minify: true,
    };
}

const promise = build(opts);

if (watch) {
    promise.then(() => {
        process.stdin.on('close', () => {
            // eslint-disable-next-line unicorn/no-process-exit
            process.exit(0);
        });

        process.stdin.resume();
    });
}

# When and how to stream
The stream is the most powerful and misunderstood feature, it changes the way to use the data, especial a large one and empowers the way to use memory with the large data.

The memory usage and the I/O for data is important in a computer, so let figure it out.

## What is the stream
> Streams are an event-based API for managing and modeling data, and are wonderfully efficient. By leveraging EventEmitter and Node’s non-blocking I/O libraries,
the stream module allows data to be dynamically processed when it’s available, and
then released when it’s no longer needed.

Took it from `Node in practice` and I think it is a great explaination to tell everyone what stream is and how use it.

* An event-base API for managing and modeling data, it is an abstract interface and can be called as a protocol.
* use it via some events by the EventEmitter, it can be used by everyone easily.

## When to use
* The input data cannot be read into the memory, like a big file.
* Use the memory efficiently.

## How to use
* Readable

```
var Readable = require('stream').Readable;

function MyStream(options) {
    Readable.call(this, options);
}

MyStream.prototype = Object.create(Readable.prototype, {
    constructor: { value: MyStream }
});
```

* Writeable

```
var stream = require('stream');

GreenStream.prototype = Object.create(stream.Writable.prototype, {
    constructor: { value: GreenStream }
});

function GreenStream(options) {
    stream.Writable.call(this, options);
}

GreenStream.prototype._write = function(chunk, encoding, callback) {
    process.stdout.write('u001b[32m' + chunk + 'u001b[39m');
    callback();
};

process.stdin.pipe(new GreenStream());
```

* Transform

```
var fs = require('fs');
var stream = require('stream');

CSVParser.prototype = Object.create(stream.Transform.prototype, {
    constructor: { value: CSVParser }
});

function CSVParser(options) {
    stream.Transform.call(this, options);
    this.value = '';
    this.headers = [];
    this.values = [];
    this.line = 0;
}

CSVParser.prototype._transform = function(chunk, encoding, done) {
    var c;
    var i;
    chunk = chunk.toString();
    for (i = 0; i < chunk.length; i++) {
        c = chunk.charAt(i);
        if (c === ',') {
            this.addValue();
        } else if (c === 'n') {
            this.addValue();
            if (this.line > 0) {
                this.push(JSON.stringify(this.toObject()));
            }
            this.values = [];
            this.line++;
        } else {
            this.value += c;
        }
    }
    done();
};

CSVParser.prototype.toObject = function() {
    var i;
    var obj = {};
    for (i = 0; i < this.headers.length; i++) {
        obj[this.headers[i]] = this.values[i];
    }
    return obj;
};

CSVParser.prototype.addValue = function() {
    if (this.line === 0) {
        this.headers.push(this.value);
    } else {
        this.values.push(this.value);
    }
    this.value = '';
};

var parser = new CSVParser();

fs.createReadStream(__dirname + '/sample.csv')
    .pipe(parser)
    .pipe(process.stdout);
```

* Duplex

```
var stream = require('stream');

HungryStream.prototype = Object.create(stream.Duplex.prototype, {
    constructor: { value: HungryStream }
});

function HungryStream(options) {
    stream.Duplex.call(this, options);
    this.waiting = false;
}

HungryStream.prototype._write = function(chunk, encoding, callback) {
    this.waiting = false;
    this.push('u001b[32m' + chunk + 'u001b[39m');
    callback();
};

HungryStream.prototype._read = function(size) {
    if (!this.waiting) {
        this.push('Feed me data! > ');
        this.waiting = true;
    }
};

var hungryStream = new HungryStream();

process.stdin.pipe(hungryStream).pipe(process.stdout);
```

* PassThrough

## References
* [Node Stream](https://nodejs.org/api/stream.html)
* [Understanding Streams in Node.js](https://nodesource.com/blog/understanding-streams-in-nodejs/)
* [How to use streams in Node.js](https://fauna.com/blog/how-to-use-node-js-streams)
* [Chapter 5. Streams: Node’s most powerful and misunderstood feature](https://livebook.manning.com/book/node-js-in-practice/chapter-5/128)

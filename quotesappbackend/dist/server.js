"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const client_1 = require("@prisma/client");
const app = (0, express_1.default)();
app.use(express_1.default.json());
const prisma = new client_1.PrismaClient();
app.get("/quotes/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("get by id request");
    const id = req.params.id;
    // Now you have the id available for further processing
    // You can use it to fetch data from your database or perform other operations
    // For example, you can fetch a quote with this id from the database using Prisma
    try {
        const quote = yield prisma.quote.findUnique({
            where: {
                id: parseInt(id) // Assuming id is stored as a number in your database
            }
        });
        if (!quote) {
            // If no quote is found with the given id, send a 404 Not Found response
            res.status(404).json({ error: "Quote not found" });
        }
        else {
            // If a quote is found, send it as a JSON response
            res.json(quote);
        }
    }
    catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quote:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}));
app.get("/quotes/:startId/:endId", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("get with range request");
    const startId = parseInt(req.params.startId);
    const endId = parseInt(req.params.endId);
    try {
        // Fetch quotes within the specified range of IDs
        const quotes = yield prisma.quote.findMany({
            where: {
                id: {
                    gt: 1455
                }
            }
        });
        // Send the retrieved quotes as a JSON response
        res.json(quotes);
    }
    catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quotes:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}));
app.get("/quotes/", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("get with range request");
    const quotesRows = yield prisma.quote.count();
    const random = Math.floor(Math.random() * quotesRows);
    try {
        // Fetch quotes within the specified range of IDs
        const quotes = yield prisma.quote.findMany({
            where: {
                id: {
                    gte: random,
                    lte: random + 10
                }
            }
        });
        // Send the retrieved quotes as a JSON response
        res.json(quotes);
    }
    catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quotes:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}));
app.post("/quotes", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("post request");
    console.log(req.body);
    // Destructure author and quote from req.body
    const { author, quote } = req.body;
    try {
        // Create a new quote using Prisma client
        const newQuote = yield prisma.quote.create({
            data: {
                author,
                quote
            }
        });
        // Respond with the newly created quote
        res.json(newQuote);
    }
    catch (error) {
        // Log the error and respond with a 500 status code and error message
        console.error("Error creating quote:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}));
app.listen(3000, () => {
    console.log("listenning for requests on port 3000");
});

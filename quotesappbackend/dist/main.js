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
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
const getSingleQuote = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const response = yield fetch(`https://dummyjson.com/quotes/${id}`);
    if (response.ok) {
        const data = yield response.json();
        return data;
    }
    return "FETCHING WAS NOT OK";
});
const fetchQuotes = () => __awaiter(void 0, void 0, void 0, function* () {
    let running = true;
    let i = 0;
    while (running) {
        i += 1;
        const quote = yield getSingleQuote(i);
        if (quote) {
            const createdQuote = yield prisma.quote.create({ data: quote });
            console.log(createdQuote);
        }
        else {
            console.log("error fetching");
            running = false;
        }
    }
});
fetchQuotes();

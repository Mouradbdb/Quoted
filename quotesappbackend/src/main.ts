import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

const getSingleQuote = async (id: number) => {
    const response = await fetch(`https://dummyjson.com/quotes/${id}`);
    if (response.ok) {
        const data = await response.json();
        return data;
    }
    return "FETCHING WAS NOT OK";
};

const fetchQuotes = async () => {
    let running = true
    let i = 0;
    while (running) {
        i += 1;
        const quote = await getSingleQuote(i);
        if (quote) {
            const createdQuote = await prisma.quote.create({ data: quote })
            console.log(createdQuote);
        }
        else {
            console.log("error fetching")
            running = false
        }
    }
};

fetchQuotes();


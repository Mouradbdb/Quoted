import express from "express"
import { PrismaClient } from "@prisma/client"

const app = express()
app.use(express.json());

const prisma = new PrismaClient()


app.get("/quotes/:id", async (req, res) => {
    console.log("get by id request")
    const id = req.params.id;
    // Now you have the id available for further processing
    // You can use it to fetch data from your database or perform other operations
    // For example, you can fetch a quote with this id from the database using Prisma
    try {
        const quote = await prisma.quote.findUnique({
            where: {
                id: parseInt(id) // Assuming id is stored as a number in your database
            }
        });
        if (!quote) {
            // If no quote is found with the given id, send a 404 Not Found response
            res.status(404).json({ error: "Quote not found" });
        } else {
            // If a quote is found, send it as a JSON response
            res.json(quote);
        }
    } catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quote:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});
app.get("/quotes/:startId/:endId", async (req, res) => {
    console.log("get with range request")

    const startId = parseInt(req.params.startId);
    const endId = parseInt(req.params.endId);
    try {
        // Fetch quotes within the specified range of IDs
        const quotes = await prisma.quote.findMany({
            where: {
                id: {
                    gt: 1455
                }
            }
        });
        // Send the retrieved quotes as a JSON response
        res.json(quotes);
    } catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quotes:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});


app.get("/quotes/", async (req, res) => {
    console.log("get with range request")
    const quotesRows = await prisma.quote.count()
    const random = Math.floor(Math.random() * quotesRows)
    try {
        // Fetch quotes within the specified range of IDs
        const quotes = await prisma.quote.findMany({
            where: {
                id: {
                    gte: random,
                    lte: random + 10

                }
            }
        });
        // Send the retrieved quotes as a JSON response
        res.json(quotes);
    } catch (error) {
        // If an error occurs during database operation, send a 500 Internal Server Error response
        console.error("Error fetching quotes:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.post("/quotes", async (req, res) => {
    console.log("post request");
    console.log(req.body)

    // Destructure author and quote from req.body
    const { author, quote } = req.body;

    try {
        // Create a new quote using Prisma client
        const newQuote = await prisma.quote.create({
            data: {
                author,
                quote
            }
        });

        // Respond with the newly created quote
        res.json(newQuote);
    } catch (error) {
        // Log the error and respond with a 500 status code and error message
        console.error("Error creating quote:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});




app.listen(3000, () => {
    console.log("listenning for requests on port 3000")
})
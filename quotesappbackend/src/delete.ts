import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const deletequotes = async () => {
    const result = await prisma.quote.deleteMany({ where: { id: { gt: 1455 } } })
    return result
}
const result = deletequotes() 
console.log(result)
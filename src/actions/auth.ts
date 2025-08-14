"use server"

import { currentUser } from "@clerk/nextjs/server"
import { Prisma } from "@prisma/client";
import { stat } from "fs";
import { UserLock } from "lucide-react";
import { use } from "react";
// import { stat } from "fs

export async function onAuthenticateUser(){
   try {  
    const user = await currentUser();
    if (!user) {
        return {
            status: 401,
            message: "Unauthorized: No user found"
        }
    }

    const userExists = await prisma.user.findUnique({
        where:{
            clerkId:user.emailAddresses[0].emailAddress,

        }
    })

    if(userExists){
        return{
            status: 200,
            user:userExists,
        }
    }

    const newUser = await prisma.user.client({
        data:{
            clerkId: user.id,
            email:user.emailAddresses[0].emailAddress,
            name:user.firstName + " " + user.lastName,
            profileImage:user.imageUrl,
        }
    })
    
    if(!newUser){
        return {
            status: 500,
            message: "Internal Server Error: User creation failed"
        }
    }

    return {
        status: 200,
        user: newUser,
    }


    
   } catch (error) {
    console.error("Error during user authentication:", error);
    return {status:500,error:"Internal Server Error: " }
   }
  

}

// Todo :implement the auth callback logic here

export const dynamic = "force-dynamic";
import { currentUser } from "@clerk/nextjs/server";
// import { prisma } from "@/lib/prisma";
import { onAuthenticateUser } from "../../../src/actions/auth";
import { redirect } from "next/navigation";

const AuthCallbackPage = async () => {
    const auth=await onAuthenticateUser();
    if(auth.status==200){
        redirect("/home")
    }
    else if(auth.status===403 ||auth.status==500||auth.status==400){
        redirect("/")
    }
    else{
        redirect("/")
    }
    return <div>AuthCallbackPage</div>
}

export default AuthCallbackPage;
import { Button } from "@/components/ui/button";
import { Waitlist } from "@clerk/nextjs";

export default function Home() {
  return (
    <div>
      <h1>Welcome to SmartCast</h1>
      <div className="flex justify-center items-center h-screen">
      <Waitlist/>
      </div>
    </div>
  );
}

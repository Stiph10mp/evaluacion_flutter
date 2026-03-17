import { connect } from "../config/db/connect.js";

class ProfileModel {
    constructor(id, email, name, photo, user){
        this.id = id
        this.email = email
        this.name = name
        this.photo = photo
        this.user = user
    }

    async addProfile(req, res){
        try{
            const { email, name, photo, user} = req.body
            if(!email || !name || !photo || !user){
                return res.status(400).json({error: "Missing required fields"})
            }

            let sqlQuery = "INSERT INTO profiles (Profile_email, Profile_name, Profile_photo, User_id_fk) VALUES (?,?,?,?)"
            const [ result ] = await connect.query(sqlQuery, [email, name, photo, user])
            res.status(201).json({
                data: [{id: result.insertId, email, name, photo, user }],
                status: 201
            })
        }
        catch(error){
            res.status(500).json({
                error: "Error adding role", details: error.message
            })
        }
    }

    async updateProfile(req, res) {
        try{
            const { email, name, photo, user} = req.body
            if(!email || !name || !photo|| !user){
                return res.status(400).json({error: "Missing required fields"})
            }   

            let sqlQuery = "UPDATE profiles SET Profile_email=?, Profile_name=?, Profile_photo=?, User_id_fk=?, update_at=? WHERE Profile_id=?"
            const update_at = new Date().toLocaleString("en-CA", {timeZone : "America/Bogota"}).replace(",", "").replace("/", "-").replace("/","-")
            const [result] = await connect.query(sqlQuery [email, name, photo, user, update_at, req.params.id])
            if (result.affectedRows === 0) return res.status(404).json({ error: "Profile not found"})
            res.status(200).json({
                data: [{email, name, photo, user, update_at}],
                status: 200,
                updated: result.affectedRows
            })
        }
        catch(error){
            res.status(500).json({ error: "Error updating profiles", details: error.message})
            
        }
    }

    async deleteProfile(req, res){
        try{
            let sqlQuery = "DELETE FROM profiles WHERE Profile_id =?"
            const [result] = await connect.query(sqlQuery, [req.params.id])
            if(result.affectedRows === 0) return res.status(404).json({ error: "Profile not found"})
            res.status(200).json({
                data: [],
                status: 200,
                deleted: result.affectedRows
        })
        }
        catch(error){
            res.status(500).json({ error: "Error deleting Profile", details: error.message})
        }
    }

    async showProfile (res){
        try{
            let sqlQuery = "SELECT * FROM profiles"
            const [result] = await connect.query(sqlQuery)
            res.status(200).json(result)
        }
        catch(error){
            res.status(404).json({error: "Error fetching profiles", details: error.message})
        }
    }

    async showProfileById (req, res){
        try{
            const [result] = connect.query("SELECT * FROM profiles WHERE Profile_id =?", [req.params.id])
            if (result.lenght === 0) return res.status(404).json({error: "Profile not found"})
            res.status(200).json(result[0])
        }
        catch(error){
            res.status(500).json({ error: "Error finding profile", details: error.message})
        }
    }

}

export default ProfileModel
